require 'test_helper'

class CharactersControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  def assert_login
    assert_redirected_to new_user_session_path
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]
  end

  def assert_denied
    assert_redirected_to root_path
    assert_equal "Access denied!", flash[:error]
  end

  test "should get index as nobody" do
    get :index, params: {:chronicle_id => Chronicle.first}
    assert_response :success, @response.body
    assert_not_nil assigns(:pcs)
    assert_not_nil assigns(:npcs)

    # asserts the change_chronicle dropdown works
    assert_select "select" do |elements|
      elements.each do |element|
        assert_select element, "option", {:minimum => 1}
      end
    end

    # asserts presence of known characters
    Character.known_to(User.new, chronicles(:two).id).each do |character|
      assert_select "td", /#{character.name}/
    end

    # ensure hidden characters don't show
    (Character.all - Character.known_to(User.new, chronicles(:two).id)).each do |char|
      assert_select "td", { count: 0, text: /#{char.name}/ }
    end
  end

  test "should get index as user" do
    sign_in(users(:one))

    get :index, params: {:chronicle_id => Chronicle.find(users(:one).selected_chronicle_id)}
    assert_response :success, @response.body
    assert_not_nil assigns(:pcs)
    assert_not_nil assigns(:npcs)

    # asserts the change_chronicle dropdown works
    assert_select "select" do |elements|
      elements.each do |element|
        assert_select element, "option", {:minimum => 1}
      end
    end

    # asserts presence of known characters
    Character.known_to(users(:one), chronicles(:two).id).each do |character|
      assert_select "td", /#{character.name}/
    end

    # ensure hidden characters don't show
    (Character.all - Character.known_to(users(:one), chronicles(:two).id)).each do |char|
      assert_select "td", { count: 0, text: /#{char.name}/ }
    end
  end

  test "should get index as ST" do
    sign_in(users(:Storyteller))

    get :index, params: {:chronicle_id => characters(:two).chronicle}
    assert_response :success, @response.body
    assert_not_nil assigns(:characters)

    # asserts the change_chronicle dropdown works
    assert_select "select" do |elements|
      elements.each do |element|
        assert_select element, "option", {:minimum => 1}
      end
    end

    # asserts presence of known characters
    Character.known_to(users(:Storyteller), chronicles(:one).id).each do |character|
      assert_select "td", /#{character.name}/
    end

    # ensure hidden characters don't show
    (Character.all - Character.known_to(users(:Storyteller), chronicles(:one).id)).each do |char|
      assert_select "td", { count: 0, text: /#{char.name}/ }
    end
  end

  test "should get new" do
    sign_in(users(:one))

    get :new, params: {:splat_id => splats(:one).id, :nature_id => natures(:one).id, :subnature_id => subnatures(:one).id, :chronicle_id => chronicles(:one).id, :ideology_id => ideologies(:one).id}
    assert_response :success, @response.body
  end

  test "shouldn't get new" do
    get :new, params: {:chronicle_id => Chronicle.first}

    assert_login
  end

  test "should create character" do
    sign_in(users(:one))

    assert_difference('Character.count') do
      post :create, params: {:character => { :name => "unique", :concept => "just a guy", :splat_id => splats(:one).id, :chronicle_id => chronicles(:one).id, :nature_id => natures(:one).id, :subnature_id => subnatures(:one).id, :ideology_id => ideologies(:one).id, :clique_id => cliques(:one).id }, :chronicle_id => chronicles(:one)}
    end

    assert_redirected_to chronicle_character_path(assigns(:character).chronicle, assigns(:character))
  end

  test "shouldn't create character" do
    assert_no_difference('Character.count') do
      post :create, params: {:character => { }, :chronicle_id => characters(:one).chronicle}
    end

    assert_login
  end

  test "should show character if public" do
    # not logged in
    get :show, params: {:id => characters(:one).to_param, :chronicle_id => characters(:one).chronicle}

    assert_response :success, @response.body
    assert_not_nil assigns(:character)

    # testing shapeshift action
    get :shapeshift, xhr: true, params: {:id => characters(:one).id, :form => "hishu", :chronicle_id => characters(:one).chronicle}

    count = 0
    response.body.split("\n").each { |line| count += 1 if line =~ /html/ }
    assert count == 10, "too few updates: #{count}"

  end

  test "should show character to ST" do
    # ST can see all characters
    sign_in(users(:Storyteller))

    get :show, params: {:id => characters(:two).to_param, :chronicle_id => characters(:two).chronicle}
    assert_response :success, @response.body
    assert_not_nil assigns(:character)

    # testing shapeshift action
    get :shapeshift, xhr: true, params: {:id => characters(:one).id, :form => "hishu", :chronicle_id => characters(:one).chronicle}

    count = 0
    response.body.split("\n").each { |line| count += 1 if line =~ /html/ }
    assert count == 10, "too few updates: #{count}"
  end

  test "should show own characters" do
    # can see own characters
    sign_in(users(:one))

    get :show, params: {:id => characters(:one).to_param, :chronicle_id => characters(:one).chronicle}
    assert_response :success, @response.body

    # testing shapeshift action
    get :shapeshift, xhr: true, params: {:id => characters(:one).id, :form => "hishu", :chronicle_id => characters(:one).chronicle}

    count = 0
    response.body.split("\n").each { |line| count += 1 if line =~ /html/ }
    assert count == 10, "too few updates: #{count}"
    assert_not_nil assigns(:character)
  end

  test "should show characters in own chronicle" do
    # can see others' characters in own chronicle
    sign_in(users(:two))

    get :show, params: {:id => characters(:three).to_param, :chronicle_id => characters(:three).chronicle}
    assert_response :success, @response.body

    # testing shapeshift action
    get :shapeshift, xhr: true, params: {:id => characters(:one).id, :form => "hishu", :chronicle_id => characters(:one).chronicle}

    count = 0
    response.body.split("\n").each { |line| count += 1 if line =~ /html/ }
    assert count == 10, "too few updates: #{count}"
    assert_not_nil assigns(:character)
  end

  test "should show character with a weird name" do
    sign_in(users(:one))

    char = Character.find_by_id(characters(:one).id)
    char.name = "dr. w#!rd _n[am}e?"
    char.save!

    get :show, params: {:id => characters(:one).to_param, :chronicle_id => characters(:one).chronicle}
    assert_response :success, @response.body
  end

  test "validate form view functionality" do
    sign_in(users(:one))

    # start with a valid base
    get :new, params: {:splat_id => splats(:one).id, :chronicle_id => chronicles(:one).id, :ideology_id => ideologies(:one).id, :nature_id => natures(:one).id}

    assert_select 'select', :attributes => {:id => 'nature_id'}, :child => {:tag => "option", :content => /#{natures(:two).name}/}
    assert_select 'select', :attributes => {:id => 'character_subnature_id'}, :child => {:tag => "option", :content => /#{subnatures(:one).name}/}
    assert_select 'select', :attributes => {:id => 'character_ideology_id'}, :child => {:tag => "option", :content => /#{ideologies(:one).name}/}
    assert_select 'select', :attributes => {:id => 'character_clique_id'}, :child => {:tag => "option", :content => /#{cliques(:one).name}/}

    # ensure that changing chronicle updates clique select options
    get :update_chronicle, xhr: true, params: {:chronicle_id => chronicles(:one), :new_chronicle_id => chronicles(:two).to_param}

    assert response.body =~ /#{chronicles(:two).id}/, "did not include proper chronicle id"
    assert response.body =~ /MyOtherCliqueName/, "did not include proper clique name"

    # ensure that changing splat updates everything
    get :update_splat, xhr: true, params: {:splat_id => splats(:two).to_param, :chronicle_id => chronicles(:two)}

    assert response.body =~ /#{splats(:two).id}/, "didn't include proper splat id"
    assert response.body =~ /#{splats(:two).nature_name}/, "didn't include proper nature name"
    assert response.body =~ /#{Nature.find_by_splat_id(splats(:two).id).id}/, "didn't include proper nature id"
    assert response.body =~ /#{splats(:two).subnature_name}/, "didn't include proper subnature name"
    assert response.body =~ /#{Subnature.find_by_splat_id(splats(:two).id).id}/, "didn't include proper subnature id"
    assert response.body =~ /#{splats(:two).ideology_name}/, "didn't include proper ideology name"
    assert response.body =~ /#{Ideology.find_by_splat_id(splats(:two).id).id}/, "didn't include proper ideology id"
    assert response.body =~ /#{splats(:two).clique_name}/, "didn't include proper clique name"
    assert response.body =~ /#{splats(:two).morality_name}/, "didn't include proper morality name"
    assert response.body =~ /#{splats(:two).power_stat_name}/, "didn't include proper power stat name"
    assert response.body =~ /#{splats(:two).fuel_name}/, "didn't include proper fuel name"

    # ensure changing nature updates subnatures
    get :update_nature, xhr: true, params: {:nature_id => natures(:one).to_param, :chronicle_id => chronicles(:two)}

    assert response.body =~ /#{natures(:one).id}/, "didn't include proper nature id"
    assert response.body =~ /#{Subnature.find_by_nature_id(natures(:one).id).name}/, "didn't include proper nature name"

    # ensure being possessed toggles form elements
    get :possess, xhr: true, params: {:possessed => true, :chronicle_id => chronicles(:two)}

    assert response.body =~ /\$\('#primary_vice_label_cell'\).toggle\(\);/, "didn't toggle primary vice label cell"
    assert response.body =~ /\$\('#primary_vice_cell'\).toggle\(\);/, "didn't toggle primary vice cell"
    assert response.body =~ /\$\('#infernal_will_label_cell'\).toggle\(\);/, "didn't toggle infernal will label cell"
    assert response.body =~ /\$\('#infernal_will_cell'\).toggle\(\);/, "didn't toggle infernal will cell"
    assert response.body =~ /\$\('#current_infernal_will_label_cell'\).toggle\(\);/, "didn't toggle current infernal will label cell"
    assert response.body =~ /\$\('#current_infernal_will_cell'\).toggle\(\);/, "didn't toggle current infernal will cell"
    assert response.body =~ /\$\('#possessed_powers'\).slideToggle\(\);/, "didn't toggle possessed powers"
  end

  test "shouldn't show character" do
    # can't see hidden character
    sign_in(users(:one))

    get :show, params: {:id => characters(:two).to_param, :chronicle_id => characters(:two).chronicle}

    assert_redirected_to :controller => "characters", :action => "index"
    assert_equal "Access denied!", flash[:error]
  end

  test "should get edit" do
    # ST can edit all characters
    sign_in(users(:Storyteller))

    get :edit, params: {:id => characters(:one).to_param, :chronicle_id => characters(:one).chronicle}
    assert_response :success, @response.body
    assert_not_nil assigns(:character)

    # can edit own characters
    sign_in(users(:two))

    get :edit, params: {:id => characters(:two).to_param, :chronicle_id => characters(:two).chronicle}
    assert_response :success, @response.body
    assert_not_nil assigns(:character)

    # can edit other users' characters if it's your chronicle
    sign_in(users(:two))

    get :edit, params: {:id => characters(:three).to_param, :chronicle_id => characters(:three).chronicle}
    assert_response :success, @response.body
    assert_not_nil assigns(:character)
  end

  test "shouldn't get edit as nobody" do
    # not logged in
    get :edit, params: {:id => characters(:one).to_param, :chronicle_id => characters(:one).chronicle}

    assert_login
  end

  test "shouldn't get edit on other users' characters" do
    # can't edit other users' characters
    sign_in(users(:one))

    get :edit, params: {:id => characters(:two).to_param, :chronicle_id => characters(:two).chronicle}

    assert_redirected_to chronicle_character_path(characters(:two).chronicle, characters(:two))
  end

  test "should update character" do
    # ST can update all characters
    sign_in(users(:Storyteller))

    put :update, params: {:id => characters(:two).to_param, :character => {:name => "newname", :concept => "new guy", :virtue => "Charity", :splat_id => splats(:one).id, :nature_id => natures(:one).id, :clique_id => cliques(:one).id, :ideology_id => ideologies(:one).id, :read_name => "0", :read_clique => "0", :read_nature => "0", :read_ideology => "0", :description => "", :read_description => "0", :background => "", :read_background => "0", :deeds => "", :read_deeds => "1", :intelligence => "1", :strength => "1", :presence => "1", :wits => "1", :dexterity => "1", :manipulation => "1", :resolve => "1", :stamina => "1", :composure => "1", :read_crunch => "0", :academics => "0", :athletics => "0", :animal_ken => "0", :computer => "0", :brawl => "0", :empathy => "0", :crafts => "0", :drive => "0", :expression => "0", :investigation => "0", :firearms => "0", :intimidation => "0", :medicine => "0", :larceny => "0", :persuasion => "0", :occult => "0", :stealth => "0", :socialize => "0", :politics => "0", :survival => "0", :streetwise => "0", :science => "0", :weaponry => "0", :subterfuge => "0", :skill_specialties => "", :health => "6", :willpower => "2", :derangements => "", :size => "5", :initiative => "2", :speed => "5", :defense => "1", :armor => "0", :morality => "7", :power_stat => "1", :max_fuel => "7", :current_fuel => "1", :merits => "", :equipment => "", :death => "0", :fate => "0", :common_spells => "", :forces => "0", :life => "0", :matter => "0", :mind => "0", :prime => "0", :space => "0", :spirit => "0", :time => "0", :purity => "0", :glory => "0", :gifts => "", :honor => "0", :wisdom => "0", :cunning => "0", :animalism => "0", :auspex => "0", :covenant_disciplines => "", :celerity => "0", :dominate => "0", :majesty => "0", :nightmare => "0", :protean => "0", :obfuscate => "0", :vigor => "0", :transmutations => "", :dream => "0", :hearth => "0", :goblin_contracts => "", :mirror => "0", :smoke => "0", :artifice => "0", :darkness => "0", :elements => "0", :fang_and_tooth => "0", :stone => "0", :vainglory => "0", :fleeting_spring => "0", :eternal_spring => "0", :fleeting_summer => "0", :eternal_summer => "0", :fleeting_autumn => "0", :eternal_autumn => "0", :fleeting_winter => "0", :eternal_winter => "0", :boneyard => "0", :caul => "0", :keys => "", :curse => "0", :oracle => "0", :marionette => "0", :rage => "0", :shroud => "0", :ceremonies => "", :experience => "", :read_experience => "0", :tactics => ""}, :character_vice => ["Envy", "Greed"], :chronicle_id => characters(:two).chronicle}
    assert_redirected_to chronicle_character_path(assigns(:character).chronicle, assigns(:character))
    assert_equal("newname", Character.find_by_id(characters(:two).id).name, "didn't update as storyteller")

    # update own characters
    sign_in(users(:one))

    put :update, params: {:id => characters(:one).to_param, :character => {:name => "newername", :concept => 'other guy', :virtue => "Charity", :splat_id => splats(:one).id, :vice => "Envy", :nature_id => natures(:one).id, :clique_id => cliques(:one).id, :ideology_id => ideologies(:one).id, :read_name => "0", :read_clique => "0", :read_nature => "0", :read_ideology => "0", :description => "", :read_description => "0", :background => "", :read_background => "0", :deeds => "", :read_deeds => "1", :intelligence => "1", :strength => "1", :presence => "1", :wits => "1", :dexterity => "1", :manipulation => "1", :resolve => "1", :stamina => "1", :composure => "1", :read_crunch => "0", :academics => "0", :athletics => "0", :animal_ken => "0", :computer => "0", :brawl => "0", :empathy => "0", :crafts => "0", :drive => "0", :expression => "0", :investigation => "0", :firearms => "0", :intimidation => "0", :medicine => "0", :larceny => "0", :persuasion => "0", :occult => "0", :stealth => "0", :socialize => "0", :politics => "0", :survival => "0", :streetwise => "0", :science => "0", :weaponry => "0", :subterfuge => "0", :skill_specialties => "", :health => "6", :willpower => "2", :derangements => "", :size => "5", :initiative => "2", :speed => "5", :defense => "1", :armor => "0", :morality => "7", :power_stat => "1", :max_fuel => "7", :current_fuel => "1", :merits => "", :equipment => "", :death => "0", :fate => "0", :common_spells => "", :forces => "0", :life => "0", :matter => "0", :mind => "0", :prime => "0", :space => "0", :spirit => "0", :time => "0", :purity => "0", :glory => "0", :gifts => "", :honor => "0", :wisdom => "0", :cunning => "0", :animalism => "0", :auspex => "0", :covenant_disciplines => "", :celerity => "0", :dominate => "0", :majesty => "0", :nightmare => "0", :protean => "0", :obfuscate => "0", :vigor => "0", :transmutations => "", :dream => "0", :hearth => "0", :goblin_contracts => "", :mirror => "0", :smoke => "0", :artifice => "0", :darkness => "0", :elements => "0", :fang_and_tooth => "0", :stone => "0", :vainglory => "0", :fleeting_spring => "0", :eternal_spring => "0", :fleeting_summer => "0", :eternal_summer => "0", :fleeting_autumn => "0", :eternal_autumn => "0", :fleeting_winter => "0", :eternal_winter => "0", :boneyard => "0", :caul => "0", :keys => "", :curse => "0", :oracle => "0", :marionette => "0", :rage => "0", :shroud => "0", :ceremonies => "", :experience => "", :read_experience => "0", :tactics => ""}, :character_vice => ["Greed", "Envy"], :chronicle_id => characters(:one).chronicle}
    assert_redirected_to chronicle_character_path(assigns(:character).chronicle, assigns(:character))
    assert_equal("newername", Character.find_by_id(characters(:one).id).name, "didn't update own user")

    # should update other users' characters if they're in your chronicle
    # update own characters
    sign_in(users(:two))

    put :update, params: {:id => characters(:three).to_param, :character => {:name => "newerername", :concept => 'other guy', :virtue => "Charity", :splat_id => splats(:one).id, :vice => "Envy", :nature_id => natures(:one).id, :clique_id => cliques(:one).id, :ideology_id => ideologies(:one).id, :read_name => "0", :read_clique => "0", :read_nature => "0", :read_ideology => "0", :description => "", :read_description => "0", :background => "", :read_background => "0", :deeds => "", :read_deeds => "1", :intelligence => "1", :strength => "1", :presence => "1", :wits => "1", :dexterity => "1", :manipulation => "1", :resolve => "1", :stamina => "1", :composure => "1", :read_crunch => "0", :academics => "0", :athletics => "0", :animal_ken => "0", :computer => "0", :brawl => "0", :empathy => "0", :crafts => "0", :drive => "0", :expression => "0", :investigation => "0", :firearms => "0", :intimidation => "0", :medicine => "0", :larceny => "0", :persuasion => "0", :occult => "0", :stealth => "0", :socialize => "0", :politics => "0", :survival => "0", :streetwise => "0", :science => "0", :weaponry => "0", :subterfuge => "0", :skill_specialties => "", :health => "6", :willpower => "2", :derangements => "", :size => "5", :initiative => "2", :speed => "5", :defense => "1", :armor => "0", :morality => "7", :power_stat => "1", :max_fuel => "7", :current_fuel => "1", :merits => "", :equipment => "", :death => "0", :fate => "0", :common_spells => "", :forces => "0", :life => "0", :matter => "0", :mind => "0", :prime => "0", :space => "0", :spirit => "0", :time => "0", :purity => "0", :glory => "0", :gifts => "", :honor => "0", :wisdom => "0", :cunning => "0", :animalism => "0", :auspex => "0", :covenant_disciplines => "", :celerity => "0", :dominate => "0", :majesty => "0", :nightmare => "0", :protean => "0", :obfuscate => "0", :vigor => "0", :transmutations => "", :dream => "0", :hearth => "0", :goblin_contracts => "", :mirror => "0", :smoke => "0", :artifice => "0", :darkness => "0", :elements => "0", :fang_and_tooth => "0", :stone => "0", :vainglory => "0", :fleeting_spring => "0", :eternal_spring => "0", :fleeting_summer => "0", :eternal_summer => "0", :fleeting_autumn => "0", :eternal_autumn => "0", :fleeting_winter => "0", :eternal_winter => "0", :boneyard => "0", :caul => "0", :keys => "", :curse => "0", :oracle => "0", :marionette => "0", :rage => "0", :shroud => "0", :ceremonies => "", :experience => "", :read_experience => "0", :tactics => ""}, :character_vice => ["Greed", "Envy"], :chronicle_id => characters(:three).chronicle}
    assert_redirected_to chronicle_character_path(assigns(:character).chronicle, assigns(:character))
    assert_equal("newerername", Character.find_by_id(characters(:three).id).name, "didn't update other user's character in own chronicle")
  end

  test "shouldn't update character as nobody" do
    # not logged in
    put :update, params: {:id => characters(:one).to_param, :character => {:name => "newname", :virtue => "Charity", :splat_id => "1", :vice => "Envy", :nature_id => "1", :clique_id => "1", :ideology_id => "1", :read_name => "0", :read_clique => "0", :read_nature => "0", :read_ideology => "0", :description => "", :read_description => "0", :background => "", :read_background => "0", :deeds => "", :read_deeds => "1", :intelligence => "1", :strength => "1", :presence => "1", :wits => "1", :dexterity => "1", :manipulation => "1", :resolve => "1", :stamina => "1", :composure => "1", :read_crunch => "0", :academics => "0", :athletics => "0", :animal_ken => "0", :computer => "0", :brawl => "0", :empathy => "0", :crafts => "0", :drive => "0", :expression => "0", :investigation => "0", :firearms => "0", :intimidation => "0", :medicine => "0", :larceny => "0", :persuasion => "0", :occult => "0", :stealth => "0", :socialize => "0", :politics => "0", :survival => "0", :streetwise => "0", :science => "0", :weaponry => "0", :subterfuge => "0", :skill_specialties => "", :health => "6", :willpower => "2", :derangements => "", :size => "5", :initiative => "2", :speed => "5", :defense => "1", :armor => "0", :morality => "7", :power_stat => "1", :max_fuel => "7", :current_fuel => "1", :merits => "", :equipment => "", :death => "0", :fate => "0", :common_spells => "", :forces => "0", :life => "0", :matter => "0", :mind => "0", :prime => "0", :space => "0", :spirit => "0", :time => "0", :purity => "0", :glory => "0", :gifts => "", :honor => "0", :wisdom => "0", :cunning => "0", :animalism => "0", :auspex => "0", :covenant_disciplines => "", :celerity => "0", :dominate => "0", :majesty => "0", :nightmare => "0", :protean => "0", :obfuscate => "0", :vigor => "0", :transmutations => "", :dream => "0", :hearth => "0", :goblin_contracts => "", :mirror => "0", :smoke => "0", :artifice => "0", :darkness => "0", :elements => "0", :fang_and_tooth => "0", :stone => "0", :vainglory => "0", :fleeting_spring => "0", :eternal_spring => "0", :fleeting_summer => "0", :eternal_summer => "0", :fleeting_autumn => "0", :eternal_autumn => "0", :fleeting_winter => "0", :eternal_winter => "0", :boneyard => "0", :caul => "0", :keys => "", :curse => "0", :oracle => "0", :marionette => "0", :rage => "0", :shroud => "0", :ceremonies => "", :experience => "", :read_experience => "0", :tactics => ""}, :chronicle_id => characters(:one).chronicle}
    assert_login
    assert_not_equal("newname", Character.find_by_id(characters(:one).id).name, "updated when not logged in")
  end

  test "shouldn't update other users' characters" do
    # can't update others' characters
    sign_in(users(:one))

    put :update, params: {:id => characters(:two).to_param, :character => {:name => "newername", :virtue => "Charity", :splat_id => "1", :vice => "Envy", :nature_id => "1", :clique_id => "1", :ideology_id => "1", :read_name => "0", :read_clique => "0", :read_nature => "0", :read_ideology => "0", :description => "", :read_description => "0", :background => "", :read_background => "0", :deeds => "", :read_deeds => "1", :intelligence => "1", :strength => "1", :presence => "1", :wits => "1", :dexterity => "1", :manipulation => "1", :resolve => "1", :stamina => "1", :composure => "1", :read_crunch => "0", :academics => "0", :athletics => "0", :animal_ken => "0", :computer => "0", :brawl => "0", :empathy => "0", :crafts => "0", :drive => "0", :expression => "0", :investigation => "0", :firearms => "0", :intimidation => "0", :medicine => "0", :larceny => "0", :persuasion => "0", :occult => "0", :stealth => "0", :socialize => "0", :politics => "0", :survival => "0", :streetwise => "0", :science => "0", :weaponry => "0", :subterfuge => "0", :skill_specialties => "", :health => "6", :willpower => "2", :derangements => "", :size => "5", :initiative => "2", :speed => "5", :defense => "1", :armor => "0", :morality => "7", :power_stat => "1", :max_fuel => "7", :current_fuel => "1", :merits => "", :equipment => "", :death => "0", :fate => "0", :common_spells => "", :forces => "0", :life => "0", :matter => "0", :mind => "0", :prime => "0", :space => "0", :spirit => "0", :time => "0", :purity => "0", :glory => "0", :gifts => "", :honor => "0", :wisdom => "0", :cunning => "0", :animalism => "0", :auspex => "0", :covenant_disciplines => "", :celerity => "0", :dominate => "0", :majesty => "0", :nightmare => "0", :protean => "0", :obfuscate => "0", :vigor => "0", :transmutations => "", :dream => "0", :hearth => "0", :goblin_contracts => "", :mirror => "0", :smoke => "0", :artifice => "0", :darkness => "0", :elements => "0", :fang_and_tooth => "0", :stone => "0", :vainglory => "0", :fleeting_spring => "0", :eternal_spring => "0", :fleeting_summer => "0", :eternal_summer => "0", :fleeting_autumn => "0", :eternal_autumn => "0", :fleeting_winter => "0", :eternal_winter => "0", :boneyard => "0", :caul => "0", :keys => "", :curse => "0", :oracle => "0", :marionette => "0", :rage => "0", :shroud => "0", :ceremonies => "", :experience => "", :read_experience => "0", :tactics => ""}, :chronicle_id => characters(:two).chronicle}
    assert_redirected_to chronicle_character_path(assigns(:character).chronicle, assigns(:character))
    assert_not_equal("newername", Character.find_by_id(characters(:two).id).name, "updated other user's character")
  end

  test "should update notes as ST" do
    sign_in(users(:Storyteller))

    put :save_notes, xhr: true, params: {:id => characters(:one).to_param, :character => {:notes => "new notes"}, :chronicle_id => characters(:one).chronicle}

    assert_equal("new notes", Character.find_by_id(characters(:one).id).notes)
    assert response.body =~ /success.*\.png/
    assert response.body =~ /fadeOut/
    assert response.body =~ /remove/
  end

  test "should update notes as owning user" do
    sign_in(users(:one))

    put :save_notes, xhr: true, params: {:id => characters(:one).to_param, :character => {:notes => "new notes"}, :chronicle_id => characters(:one).chronicle}

    assert_equal("new notes", Character.find_by_id(characters(:one).id).notes)
    assert response.body =~ /success.*\.png/
    assert response.body =~ /fadeOut/
    assert response.body =~ /remove/
  end

  test "shouldn't update notes as non-owning user" do
    sign_in(users(:two))

    put :save_notes, xhr: true, params: {:id => characters(:one).to_param, :character => {:notes => "new notes"}, :chronicle_id => characters(:one).chronicle}

    assert_not_equal("new notes", Character.find_by_id(characters(:one).id).notes)
    assert response.body !~ /success.*\.png/
    assert response.body !~ /fadeOut/
    assert response.body !~ /remove/
  end

  test "shouldn't update notes as nobody" do
    put :save_notes, xhr: true, params: {:id => characters(:one).to_param, :character => {:notes => "new notes"}, :chronicle_id => characters(:one).chronicle}

    assert_not_equal("new notes", Character.find_by_id(characters(:one).id).notes)
    assert response.body !~ /success.*\.png/
    assert response.body !~ /fadeOut/
    assert response.body !~ /remove/
  end

  test "should update current stats as ST" do
    sign_in(users(:Storyteller))

    put :save_current, xhr: true, params: {:id => characters(:one).to_param, :character => {:current_health => "*XX", :current_willpower => "X", :current_fuel => "7"}, :chronicle_id => characters(:one).chronicle}

    assert_equal("*XX", Character.find_by_id(characters(:one).id).current_health)
    assert_equal("X", Character.find_by_id(characters(:one).id).current_willpower)
    assert_not_equal("Character was successfully updated.", flash[:notice])
  end

  test "should update current stats as owning user" do
    sign_in(users(:one))

    put :save_current, xhr: true, params: {:id => characters(:one).to_param, :character => {:current_health => "*XX", :current_willpower => "X", :current_fuel => "7"}, :chronicle_id => characters(:one).chronicle}

    assert_equal("*XX", Character.find_by_id(characters(:one).id).current_health)
    assert_equal("X", Character.find_by_id(characters(:one).id).current_willpower)
    assert_not_equal("Character was successfully updated.", flash[:notice])
  end

  test "shouldn't update current stats as non-owning user" do
    sign_in(users(:two))

    put :save_current, xhr: true, params: {:id => characters(:one).to_param, :character => {:current_health => "*XX", :current_willpower => "X", :current_fuel => "7"}, :chronicle_id => characters(:one).chronicle}

    assert_equal("1", Character.find_by_id(characters(:one).id).current_health)
    assert_equal("1", Character.find_by_id(characters(:one).id).current_willpower)
    assert_not_equal("Character was successfully updated.", flash[:notice])
  end

  test "shouldn't update current stats as nobody" do
    put :save_current, xhr: true, params: {:id => characters(:one).to_param, :character => {:current_health => "*XX", :current_willpower => "X", :current_fuel => "7"}, :chronicle_id => characters(:one).chronicle}

    assert_equal("1", Character.find_by_id(characters(:one).id).current_health)
    assert_equal("1", Character.find_by_id(characters(:one).id).current_willpower)
    assert_not_equal("Character was successfully updated.", flash[:notice])
  end

  test "should destroy character" do
    # ST can destroy all characters
    sign_in(users(:Storyteller))

    assert_difference('Character.count', -1) do
      delete :destroy, params: {:id => characters(:two).to_param, :chronicle_id => characters(:two).chronicle}
    end

    assert_redirected_to chronicle_characters_path(Chronicle.find(users(:Storyteller).selected_chronicle_id))

    # destroy own characters
    sign_in(users(:one))

    assert_difference('Character.count', -1) do
      delete :destroy, params: {:id => characters(:one).to_param, :chronicle_id => characters(:two).chronicle}
    end

    assert_redirected_to chronicle_characters_path(characters(:one).chronicle)

    # destroy other users' characters in own chronicle
    sign_in(users(:two))

    assert_difference('Character.count', -1) do
      delete :destroy, params: {:id => characters(:three).to_param, :chronicle_id => characters(:three).chronicle}
    end

    assert_redirected_to chronicle_characters_path(Chronicle.find(users(:Storyteller).selected_chronicle_id))
  end

  test "shouldn't destroy character as nobody" do
    # not logged in
    assert_no_difference "Character.count", "destroyed when not logged in" do
      delete :destroy, params: {:id => characters(:one), :chronicle_id => characters(:one)}
    end
    assert_login
  end

  test "shouldn't destroy other users' characters" do
    # can't destroy other users' characters
    sign_in(users(:one))

    assert_no_difference "Character.count", "removed another user's character" do
      delete :destroy, params: {:id => characters(:two).to_param, :chronicle_id => characters(:two).chronicle}
    end
    assert_redirected_to chronicle_character_path(characters(:two).chronicle, characters(:two))
    assert_equal("Access denied!", flash[:error])
  end

  test "should roll dice" do
    character = characters(:two)

    post :roll, xhr: true, params: {:chronicle_id => character.chronicle, :id => character, :dice_count => '3 + 2 - 2 + -1', :reroll => '10'}

    assert_equal(2, assigns(:dice_count))
    assert response.body =~ /\$\('#successes'\).html/, 'did not display successes'
    assert response.body =~ /\$\('#dice_results'\).html/, 'did not display results'
    assert response.body =~ /\$\('#results'\).effect/, 'did not highlight results'
  end
end
