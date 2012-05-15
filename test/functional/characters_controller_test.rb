require 'test_helper'

class CharactersControllerTest < ActionController::TestCase
  require 'fakeweb'
  include Devise::TestHelpers

  def setup
    FakeWeb.allow_net_connect = false
    FakeWeb.register_uri(:post, 'https://www.obsidianportal.com/oauth/request_token', :body => 'oauth_token=fake&oauth_token_secret=fake')
    FakeWeb.register_uri(:post, 'https://www.obsidianportal.com/oauth/access_token', :body => 'oauth_token=fake&oauth_token_secret=fake')
    FakeWeb.register_uri(:get, 'https://www.obsidianportal.com/oauth/authorize', :response => File.join(Rails.root.to_s, 'test', 'fixtures', 'authorize'))
    FakeWeb.register_uri(:get, 'http://api.obsidianportal.com/v1/users/me.json', :body => File.join(Rails.root.to_s, 'test', 'fixtures', 'op_user'))
    FakeWeb.register_uri(:get, 'http://api.obsidianportal.com/v1/campaigns/1/characters.json', :body => File.join(Rails.root.to_s, 'test', 'fixtures', 'op_character'))
    FakeWeb.register_uri(:get, 'http://api.obsidianportal.com/v1/campaigns/2/characters.json', :body => File.join(Rails.root.to_s, 'test', 'fixtures', 'op_character'))
    FakeWeb.register_uri(:post, 'http://api.obsidianportal.com/v1/campaigns/1/characters.json', :body => File.join(Rails.root.to_s, 'test', 'fixtures', 'op_character'))
    FakeWeb.register_uri(:put, 'http://api.obsidianportal.com/v1/campaigns/1/characters/1.json', :body => File.join(Rails.root.to_s, 'test', 'fixtures', 'op_character'))
    FakeWeb.register_uri(:put, 'http://api.obsidianportal.com/v1/campaigns/2/characters/2.json', :body => File.join(Rails.root.to_s, 'test', 'fixtures', 'op_character'))

    @request.session[:access_token_key] = "zbSBqRLcixlAVpdZ9DRQ"
    @request.session[:access_token_secret] = "XrkwQiAHQUl4U6Xzwx0mjXE90DtM4cXmz2jYDK2V"
  end

  def assert_login
    assert_redirected_to new_user_session_path
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]
  end

  def assert_denied
    assert_redirected_to root_path
    assert_equal "Access denied!", flash[:error]
  end

  test "should get index as nobody" do
    get :index
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
      assert_no_tag "td", :content => /#{char.name}/
    end

    # change chronicle via dropdown
    xhr :get, :change_chronicle, :chronicle_id => chronicles(:one).id

    # ensure hidden characters don't show
    (Character.all - Character.known_to(User.new, chronicles(:one).id)).each do |char|
      assert_no_tag "td", :content => /#{char.name}/
    end
  end
 
  test "should get index as user" do
    sign_in(users(:one))

    get :index
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
      assert_no_tag "td", :content => /#{char.name}/
    end

    # change chronicle via dropdown
    xhr :get, :change_chronicle, :chronicle_id => chronicles(:one).id
  end
  
  test "should get index as ST" do
    sign_in(users(:Storyteller))

    get :index
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
      assert_no_tag "td", :content => /#{char.name}/
    end

    # change chronicle via dropdown
    xhr :get, :change_chronicle, :chronicle_id => chronicles(:two).id
  end
 
  test "should get new" do
    sign_in(users(:one))

    get :new, :splat_id => splats(:one).id, :nature_id => natures(:one).id, :subnature_id => subnatures(:one).id, :chronicle_id => chronicles(:one).id, :ideology_id => ideologies(:one).id
    assert_template "form"
    assert_response :success, @response.body
  end

  test "shouldn't get new" do
    get :new

    assert_login
  end

  test "should create character" do
    sign_in(users(:one))

    assert_difference('Character.count') do
      post :create, :character => { :name => "unique", :concept => "just a guy", :splat_id => splats(:one).id, :chronicle_id => chronicles(:one).id, :nature_id => natures(:one).id, :subnature_id => subnatures(:one).id, :ideology_id => ideologies(:one).id, :clique_id => cliques(:one).id, :obsidian_character_id => -1 }
    end

    assert_redirected_to character_path(assigns(:character))
  end

  test "shouldn't create character" do
    assert_no_difference('Character.count') do
      post :create, :character => { }
    end

    assert_login
  end

  test "should show character" do
    # not logged in
    get :show, :id => characters(:one).to_param

    assert_response :success, @response.body
    assert_not_nil assigns(:character)

    # testing shapeshift action
    xhr :get, :shapeshift, :id => characters(:one).id, :form => "hishu"

    count = 0
    response.body.split("\n").each { |line| count += 1 if line =~ /html/ }
    assert count == 10, "too few updates: #{count}"
    
    # ST can see all characters
    sign_in(users(:Storyteller))

    get :show, :id => characters(:two).to_param
    assert_response :success, @response.body
    assert_not_nil assigns(:character)

    # testing shapeshift action
    xhr :get, :shapeshift, :id => characters(:one).id, :form => "hishu"

    count = 0
    response.body.split("\n").each { |line| count += 1 if line =~ /html/ }
    assert count == 10, "too few updates: #{count}"

    # can see own characters
    sign_in(users(:one))

    get :show, :id => characters(:one).to_param
    assert_response :success, @response.body

    # testing shapeshift action
    xhr :get, :shapeshift, :id => characters(:one).id, :form => "hishu"

    count = 0
    response.body.split("\n").each { |line| count += 1 if line =~ /html/ }
    assert count == 10, "too few updates: #{count}"
    assert_not_nil assigns(:character)
    
    # can see others' characters in own chronicle
    sign_in(users(:two))

    get :show, :id => characters(:three).to_param
    assert_response :success, @response.body

    # testing shapeshift action
    xhr :get, :shapeshift, :id => characters(:one).id, :form => "hishu"

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

    get :show, :id => characters(:one).to_param
    assert_response :success, @response.body
  end
  
  test "validate form view functionality" do
    sign_in(users(:one))
    
    # start with a valid base
    get :new, :splat_id => splats(:one).id, :chronicle_id => chronicles(:one).id, :ideology_id => ideologies(:one).id, :nature_id => natures(:one).id
    
    assert_tag :tag => 'select', :attributes => {:id => 'nature_id'}, :child => {:tag => "option", :content => /#{natures(:two).name}/}
    assert_tag :tag => 'select', :attributes => {:id => 'character_subnature_id'}, :child => {:tag => "option", :content => /#{subnatures(:one).name}/}
    assert_tag :tag => 'select', :attributes => {:id => 'character_ideology_id'}, :child => {:tag => "option", :content => /#{ideologies(:one).name}/}
    assert_tag :tag => 'select', :attributes => {:id => 'character_clique_id'}, :child => {:tag => "option", :content => /#{cliques(:one).name}/}
    
    # ensure that changing chronicle updates clique select options
    xhr :get, :update_chronicle, :chronicle_id => chronicles(:two).to_param
    
    assert response.body =~ /#{chronicles(:two).id}/, "did not include proper chronicle id"
    assert response.body =~ /MyOtherCliqueName/, "did not include proper clique name"
    
    # ensure that changing splat updates everything
    xhr :get, :update_splat, :splat_id => splats(:two).to_param
    
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
    xhr :get, :update_nature, :nature_id => natures(:one).to_param
    
    assert response.body =~ /#{natures(:one).id}/, "didn't include proper nature id"
    assert response.body =~ /#{Subnature.find_by_nature_id(natures(:one).id).name}/, "didn't include proper nature name"
    
    # ensure being possessed toggles form elements
    xhr :get, :possess, :possessed => true
    
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

    get :show, :id => characters(:two).to_param

    assert_redirected_to :controller => "characters", :action => "index"
    assert_equal "You don't have permission to do that", flash[:notice]
  end

  test "should get edit" do
    # ST can edit all characters
    sign_in(users(:Storyteller))

    get :edit, :id => characters(:one).to_param
    assert_response :success, @response.body
    assert_not_nil assigns(:character)

    # can edit own characters
    sign_in(users(:two))

    get :edit, :id => characters(:two).to_param
    assert_response :success, @response.body
    assert_not_nil assigns(:character)
    
    # can edit other users' characters if it's your chronicle
    sign_in(users(:two))

    get :edit, :id => characters(:three).to_param
    assert_response :success, @response.body
    assert_not_nil assigns(:character)
  end

  test "shouldn't get edit" do
    # not logged in
    get :edit, :id => characters(:one).to_param

    assert_login

    # can't edit other users' characters
    sign_in(users(:one))

    get :edit, :id => characters(:two).to_param

    assert_redirected_to character_path(characters(:two))
  end

  test "should update character" do
    # ST can update all characters
    sign_in(users(:Storyteller))
    
    put :update, :id => characters(:two).to_param, :character => {:name => "newname", :concept => "new guy", :virtue => "Charity", :splat_id => splats(:one).id, :nature_id => natures(:one).id, :clique_id => cliques(:one).id, :ideology_id => ideologies(:one).id, :read_name => "0", :read_clique => "0", :read_nature => "0", :read_ideology => "0", :description => "", :read_description => "0", :background => "", :read_background => "0", :deeds => "", :read_deeds => "1", :intelligence => "1", :strength => "1", :presence => "1", :wits => "1", :dexterity => "1", :manipulation => "1", :resolve => "1", :stamina => "1", :composure => "1", :read_crunch => "0", :academics => "0", :athletics => "0", :animal_ken => "0", :computer => "0", :brawl => "0", :empathy => "0", :crafts => "0", :drive => "0", :expression => "0", :investigation => "0", :firearms => "0", :intimidation => "0", :medicine => "0", :larceny => "0", :persuasion => "0", :occult => "0", :stealth => "0", :socialize => "0", :politics => "0", :survival => "0", :streetwise => "0", :science => "0", :weaponry => "0", :subterfuge => "0", :skill_specialties => "", :health => "6", :willpower => "2", :derangements => "", :size => "5", :initiative => "2", :speed => "5", :defense => "1", :armor => "0", :morality => "7", :power_stat => "1", :max_fuel => "7", :current_fuel => "1", :merits => "", :equipment => "", :death => "0", :fate => "0", :common_spells => "", :forces => "0", :life => "0", :matter => "0", :mind => "0", :prime => "0", :space => "0", :spirit => "0", :time => "0", :purity => "0", :glory => "0", :gifts => "", :honor => "0", :wisdom => "0", :cunning => "0", :animalism => "0", :auspex => "0", :covenant_disciplines => "", :celerity => "0", :dominate => "0", :majesty => "0", :nightmare => "0", :protean => "0", :obfuscate => "0", :vigor => "0", :transmutations => "", :dream => "0", :hearth => "0", :goblin_contracts => "", :mirror => "0", :smoke => "0", :artifice => "0", :darkness => "0", :elements => "0", :fang_and_tooth => "0", :stone => "0", :vainglory => "0", :fleeting_spring => "0", :eternal_spring => "0", :fleeting_summer => "0", :eternal_summer => "0", :fleeting_autumn => "0", :eternal_autumn => "0", :fleeting_winter => "0", :eternal_winter => "0", :boneyard => "0", :caul => "0", :keys => "", :curse => "0", :oracle => "0", :marionette => "0", :rage => "0", :shroud => "0", :ceremonies => "", :experience => "", :read_experience => "0", :splat_id => "1", :tactics => ""}, :character_vice => ["Envy", "Greed"]
    assert_redirected_to character_path(assigns(:character))
    assert_equal("newname", Character.find_by_id(characters(:two).id).name, "didn't update as storyteller")
    
    # update own characters
    sign_in(users(:one))
    
    put :update, :id => characters(:one).to_param, :character => {:name => "newername", :concept => 'other guy', :virtue => "Charity", :splat_id => splats(:one).id, :vice => "Envy", :nature_id => natures(:one).id, :clique_id => cliques(:one).id, :ideology_id => ideologies(:one).id, :read_name => "0", :read_clique => "0", :read_nature => "0", :read_ideology => "0", :description => "", :read_description => "0", :background => "", :read_background => "0", :deeds => "", :read_deeds => "1", :intelligence => "1", :strength => "1", :presence => "1", :wits => "1", :dexterity => "1", :manipulation => "1", :resolve => "1", :stamina => "1", :composure => "1", :read_crunch => "0", :academics => "0", :athletics => "0", :animal_ken => "0", :computer => "0", :brawl => "0", :empathy => "0", :crafts => "0", :drive => "0", :expression => "0", :investigation => "0", :firearms => "0", :intimidation => "0", :medicine => "0", :larceny => "0", :persuasion => "0", :occult => "0", :stealth => "0", :socialize => "0", :politics => "0", :survival => "0", :streetwise => "0", :science => "0", :weaponry => "0", :subterfuge => "0", :skill_specialties => "", :health => "6", :willpower => "2", :derangements => "", :size => "5", :initiative => "2", :speed => "5", :defense => "1", :armor => "0", :morality => "7", :power_stat => "1", :max_fuel => "7", :current_fuel => "1", :merits => "", :equipment => "", :death => "0", :fate => "0", :common_spells => "", :forces => "0", :life => "0", :matter => "0", :mind => "0", :prime => "0", :space => "0", :spirit => "0", :time => "0", :purity => "0", :glory => "0", :gifts => "", :honor => "0", :wisdom => "0", :cunning => "0", :animalism => "0", :auspex => "0", :covenant_disciplines => "", :celerity => "0", :dominate => "0", :majesty => "0", :nightmare => "0", :protean => "0", :obfuscate => "0", :vigor => "0", :transmutations => "", :dream => "0", :hearth => "0", :goblin_contracts => "", :mirror => "0", :smoke => "0", :artifice => "0", :darkness => "0", :elements => "0", :fang_and_tooth => "0", :stone => "0", :vainglory => "0", :fleeting_spring => "0", :eternal_spring => "0", :fleeting_summer => "0", :eternal_summer => "0", :fleeting_autumn => "0", :eternal_autumn => "0", :fleeting_winter => "0", :eternal_winter => "0", :boneyard => "0", :caul => "0", :keys => "", :curse => "0", :oracle => "0", :marionette => "0", :rage => "0", :shroud => "0", :ceremonies => "", :experience => "", :read_experience => "0", :splat_id => "1", :tactics => ""}, :character_vice => ["Greed", "Envy"]
    assert_redirected_to character_path(assigns(:character))
    assert_equal("newername", Character.find_by_id(characters(:one).id).name, "didn't update own user")
    
    # should update other users' characters if they're in your chronicle
    # update own characters
    sign_in(users(:two))
    
    put :update, :id => characters(:three).to_param, :character => {:name => "newerername", :concept => 'other guy', :virtue => "Charity", :splat_id => splats(:one).id, :vice => "Envy", :nature_id => natures(:one).id, :clique_id => cliques(:one).id, :ideology_id => ideologies(:one).id, :read_name => "0", :read_clique => "0", :read_nature => "0", :read_ideology => "0", :description => "", :read_description => "0", :background => "", :read_background => "0", :deeds => "", :read_deeds => "1", :intelligence => "1", :strength => "1", :presence => "1", :wits => "1", :dexterity => "1", :manipulation => "1", :resolve => "1", :stamina => "1", :composure => "1", :read_crunch => "0", :academics => "0", :athletics => "0", :animal_ken => "0", :computer => "0", :brawl => "0", :empathy => "0", :crafts => "0", :drive => "0", :expression => "0", :investigation => "0", :firearms => "0", :intimidation => "0", :medicine => "0", :larceny => "0", :persuasion => "0", :occult => "0", :stealth => "0", :socialize => "0", :politics => "0", :survival => "0", :streetwise => "0", :science => "0", :weaponry => "0", :subterfuge => "0", :skill_specialties => "", :health => "6", :willpower => "2", :derangements => "", :size => "5", :initiative => "2", :speed => "5", :defense => "1", :armor => "0", :morality => "7", :power_stat => "1", :max_fuel => "7", :current_fuel => "1", :merits => "", :equipment => "", :death => "0", :fate => "0", :common_spells => "", :forces => "0", :life => "0", :matter => "0", :mind => "0", :prime => "0", :space => "0", :spirit => "0", :time => "0", :purity => "0", :glory => "0", :gifts => "", :honor => "0", :wisdom => "0", :cunning => "0", :animalism => "0", :auspex => "0", :covenant_disciplines => "", :celerity => "0", :dominate => "0", :majesty => "0", :nightmare => "0", :protean => "0", :obfuscate => "0", :vigor => "0", :transmutations => "", :dream => "0", :hearth => "0", :goblin_contracts => "", :mirror => "0", :smoke => "0", :artifice => "0", :darkness => "0", :elements => "0", :fang_and_tooth => "0", :stone => "0", :vainglory => "0", :fleeting_spring => "0", :eternal_spring => "0", :fleeting_summer => "0", :eternal_summer => "0", :fleeting_autumn => "0", :eternal_autumn => "0", :fleeting_winter => "0", :eternal_winter => "0", :boneyard => "0", :caul => "0", :keys => "", :curse => "0", :oracle => "0", :marionette => "0", :rage => "0", :shroud => "0", :ceremonies => "", :experience => "", :read_experience => "0", :splat_id => "1", :tactics => ""}, :character_vice => ["Greed", "Envy"]
    assert_redirected_to character_path(assigns(:character))
    assert_equal("newerername", Character.find_by_id(characters(:three).id).name, "didn't update other user's character in own chronicle")
  end

  test "shouldn't update character" do
    # not logged in    
    put :update, :id => characters(:one).to_param, :character => {:name => "newname", :virtue => "Charity", :splat_id => "1", :vice => "Envy", :nature_id => "1", :clique_id => "1", :ideology_id => "1", :read_name => "0", :read_clique => "0", :read_nature => "0", :read_ideology => "0", :description => "", :read_description => "0", :background => "", :read_background => "0", :deeds => "", :read_deeds => "1", :intelligence => "1", :strength => "1", :presence => "1", :wits => "1", :dexterity => "1", :manipulation => "1", :resolve => "1", :stamina => "1", :composure => "1", :read_crunch => "0", :academics => "0", :athletics => "0", :animal_ken => "0", :computer => "0", :brawl => "0", :empathy => "0", :crafts => "0", :drive => "0", :expression => "0", :investigation => "0", :firearms => "0", :intimidation => "0", :medicine => "0", :larceny => "0", :persuasion => "0", :occult => "0", :stealth => "0", :socialize => "0", :politics => "0", :survival => "0", :streetwise => "0", :science => "0", :weaponry => "0", :subterfuge => "0", :skill_specialties => "", :health => "6", :willpower => "2", :derangements => "", :size => "5", :initiative => "2", :speed => "5", :defense => "1", :armor => "0", :morality => "7", :power_stat => "1", :max_fuel => "7", :current_fuel => "1", :merits => "", :equipment => "", :death => "0", :fate => "0", :common_spells => "", :forces => "0", :life => "0", :matter => "0", :mind => "0", :prime => "0", :space => "0", :spirit => "0", :time => "0", :purity => "0", :glory => "0", :gifts => "", :honor => "0", :wisdom => "0", :cunning => "0", :animalism => "0", :auspex => "0", :covenant_disciplines => "", :celerity => "0", :dominate => "0", :majesty => "0", :nightmare => "0", :protean => "0", :obfuscate => "0", :vigor => "0", :transmutations => "", :dream => "0", :hearth => "0", :goblin_contracts => "", :mirror => "0", :smoke => "0", :artifice => "0", :darkness => "0", :elements => "0", :fang_and_tooth => "0", :stone => "0", :vainglory => "0", :fleeting_spring => "0", :eternal_spring => "0", :fleeting_summer => "0", :eternal_summer => "0", :fleeting_autumn => "0", :eternal_autumn => "0", :fleeting_winter => "0", :eternal_winter => "0", :boneyard => "0", :caul => "0", :keys => "", :curse => "0", :oracle => "0", :marionette => "0", :rage => "0", :shroud => "0", :ceremonies => "", :experience => "", :read_experience => "0", :splat_id => "1", :tactics => ""}
    assert_login
    assert_not_equal("newname", Character.find_by_id(characters(:one).id).name, "updated when not logged in")
    
    # can't update others' characters
    sign_in(users(:one))
    
    put :update, :id => characters(:two).to_param, :character => {:name => "newername", :virtue => "Charity", :splat_id => "1", :vice => "Envy", :nature_id => "1", :clique_id => "1", :ideology_id => "1", :read_name => "0", :read_clique => "0", :read_nature => "0", :read_ideology => "0", :description => "", :read_description => "0", :background => "", :read_background => "0", :deeds => "", :read_deeds => "1", :intelligence => "1", :strength => "1", :presence => "1", :wits => "1", :dexterity => "1", :manipulation => "1", :resolve => "1", :stamina => "1", :composure => "1", :read_crunch => "0", :academics => "0", :athletics => "0", :animal_ken => "0", :computer => "0", :brawl => "0", :empathy => "0", :crafts => "0", :drive => "0", :expression => "0", :investigation => "0", :firearms => "0", :intimidation => "0", :medicine => "0", :larceny => "0", :persuasion => "0", :occult => "0", :stealth => "0", :socialize => "0", :politics => "0", :survival => "0", :streetwise => "0", :science => "0", :weaponry => "0", :subterfuge => "0", :skill_specialties => "", :health => "6", :willpower => "2", :derangements => "", :size => "5", :initiative => "2", :speed => "5", :defense => "1", :armor => "0", :morality => "7", :power_stat => "1", :max_fuel => "7", :current_fuel => "1", :merits => "", :equipment => "", :death => "0", :fate => "0", :common_spells => "", :forces => "0", :life => "0", :matter => "0", :mind => "0", :prime => "0", :space => "0", :spirit => "0", :time => "0", :purity => "0", :glory => "0", :gifts => "", :honor => "0", :wisdom => "0", :cunning => "0", :animalism => "0", :auspex => "0", :covenant_disciplines => "", :celerity => "0", :dominate => "0", :majesty => "0", :nightmare => "0", :protean => "0", :obfuscate => "0", :vigor => "0", :transmutations => "", :dream => "0", :hearth => "0", :goblin_contracts => "", :mirror => "0", :smoke => "0", :artifice => "0", :darkness => "0", :elements => "0", :fang_and_tooth => "0", :stone => "0", :vainglory => "0", :fleeting_spring => "0", :eternal_spring => "0", :fleeting_summer => "0", :eternal_summer => "0", :fleeting_autumn => "0", :eternal_autumn => "0", :fleeting_winter => "0", :eternal_winter => "0", :boneyard => "0", :caul => "0", :keys => "", :curse => "0", :oracle => "0", :marionette => "0", :rage => "0", :shroud => "0", :ceremonies => "", :experience => "", :read_experience => "0", :splat_id => "1", :tactics => ""}
    assert_redirected_to character_path(assigns(:character))
    assert_not_equal("newername", Character.find_by_id(characters(:two).id).name, "updated other user's character")
  end

  test "should update notes as ST" do
    sign_in(users(:Storyteller))

    xhr :put, :save_notes, :id => characters(:one).to_param, :character => {:notes => "new notes"}

    assert_equal("new notes", Character.find_by_id(characters(:one).id).notes)
    assert response.body =~ /success.*\.png/
    assert response.body =~ /fadeOut/
    assert response.body =~ /remove/
  end
  
  test "should update notes as owning user" do
    sign_in(users(:one))

    xhr :put, :save_notes, :id => characters(:one).to_param, :character => {:notes => "new notes"}

    assert_equal("new notes", Character.find_by_id(characters(:one).id).notes)
    assert response.body =~ /success.*\.png/
    assert response.body =~ /fadeOut/
    assert response.body =~ /remove/
  end
  
  test "shouldn't update notes as non-owning user" do
    sign_in(users(:two))

    xhr :put, :save_notes, :id => characters(:one).to_param, :character => {:notes => "new notes"}

    assert_not_equal("new notes", Character.find_by_id(characters(:one).id).notes)
    assert response.body !~ /success.*\.png/
    assert response.body !~ /fadeOut/
    assert response.body !~ /remove/
  end
  
  test "shouldn't update notes as nobody" do
    xhr :put, :save_notes, :id => characters(:one).to_param, :character => {:notes => "new notes"}

    assert_not_equal("new notes", Character.find_by_id(characters(:one).id).notes)
    assert response.body !~ /success.*\.png/
    assert response.body !~ /fadeOut/
    assert response.body !~ /remove/
  end
  
  test "should update current stats as ST" do
    sign_in(users(:Storyteller))
    
    xhr :put, :save_current, :id => characters(:one).to_param, :character => {:current_health => "*XX", :current_willpower => "X", :current_fuel => "7"}
    
    assert_equal("*XX", Character.find_by_id(characters(:one).id).current_health)
    assert_equal("X", Character.find_by_id(characters(:one).id).current_willpower)
    assert_not_equal("Character was successfully updated.", flash[:notice])
  end
  
  test "should update current stats as owning user" do
    sign_in(users(:one))
    
    xhr :put, :save_current, :id => characters(:one).to_param, :character => {:current_health => "*XX", :current_willpower => "X", :current_fuel => "7"}
    
    assert_equal("*XX", Character.find_by_id(characters(:one).id).current_health)
    assert_equal("X", Character.find_by_id(characters(:one).id).current_willpower)
    assert_not_equal("Character was successfully updated.", flash[:notice])
  end
  
  test "shouldn't update current stats as non-owning user" do
    sign_in(users(:two))
    
    xhr :put, :save_current, :id => characters(:one).to_param, :character => {:current_health => "*XX", :current_willpower => "X", :current_fuel => "7"}
    
    assert_equal("1", Character.find_by_id(characters(:one).id).current_health)
    assert_equal("1", Character.find_by_id(characters(:one).id).current_willpower)
    assert_not_equal("Character was successfully updated.", flash[:notice])
  end
  
  test "shouldn't update current stats as nobody" do
    xhr :put, :save_current, :id => characters(:one).to_param, :character => {:current_health => "*XX", :current_willpower => "X", :current_fuel => "7"}
    
    assert_equal("1", Character.find_by_id(characters(:one).id).current_health)
    assert_equal("1", Character.find_by_id(characters(:one).id).current_willpower)
    assert_not_equal("Character was successfully updated.", flash[:notice])
  end
  
  test "should destroy character" do
    # ST can destroy all characters
    sign_in(users(:Storyteller))
    
    assert_difference('Character.count', -1) do
      delete :destroy, :id => characters(:two).to_param
    end

    assert_redirected_to characters_path

    # destroy own characters
    sign_in(users(:one))
    
    assert_difference('Character.count', -1) do
      delete :destroy, :id => characters(:one).to_param
    end

    assert_redirected_to characters_path
    
    # destroy other users' characters in own chronicle
    sign_in(users(:two))
    
    assert_difference('Character.count', -1) do
      delete :destroy, :id => characters(:three).to_param
    end

    assert_redirected_to characters_path
  end
  
  test "shouldn't destroy character" do
    # not logged in
    assert_no_difference "Character.count", "destroyed when not logged in" do
      delete :destroy, :id => characters(:one).to_param
    end
    assert_login
    
    # can't destroy other users' characters
    sign_in(users(:one))
    
    assert_no_difference "Character.count", "removed another user's character" do
      delete :destroy, :id => characters(:two).to_param
    end
    assert_redirected_to character_path(characters(:two))
    assert_equal("Access denied!", flash[:error])
  end
end
