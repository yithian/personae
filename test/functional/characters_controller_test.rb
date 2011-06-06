require 'test_helper'

class CharactersControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  test "should get index" do
    sign_in(users(:one))

    get :index
    assert_response :success
    assert_not_nil assigns(:characters)
  end

  test "shouldn't get index" do
    get :index
    assert_redirected_to :controller => "users", :action => "sign_in"
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]
    assert_nil assigns(:characters), "got past authentication"
  end

  test "should get new" do
    sign_in(users(:one))

    get :new, :splat_id => splats(:one).id, :nature_id => natures(:one).id, :chronicle_id => chronicles(:one).id, :ideology_id => ideologies(:one).id
    assert_response :success
  end

  test "shouldn't get new" do
    get :new
    assert_redirected_to :controller => "users", :action => "sign_in"
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]
  end

  test "should create character" do
    sign_in(users(:one))

    assert_difference('Character.count') do
      post :create, :character => { :name => "unique", :splat_id => splats(:one).id, :chronicle_id => chronicles(:one).id, :subnature_id => subnatures(:one).id }
    end

    assert_redirected_to character_path(assigns(:character))
  end

  test "shouldn't create character" do
    assert_no_difference('Character.count') do
      post :create, :character => { }
    end

    assert_redirected_to :controller => "users", :action => "sign_in"
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]
  end

  test "should show character" do
    # ST can see all characters
    sign_in(users(:Storyteller))

    get :show, :id => characters(:two).to_param
    assert_response :success

    # can see own characters
    sign_in(users(:one))

    get :show, :id => characters(:one).to_param
    assert_response :success
  end

  test "shouldn't show character" do
    # not logged in
    get :show, :id => characters(:one).to_param

    assert_redirected_to :controller => "users", :action => "sign_in"
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]

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
    assert_response :success

    # can edit own characters
    sign_in(users(:two))

    get :edit, :id => characters(:two).to_param
    assert_response :success
  end

  test "shouldn't get edit" do
    # not logged in
    get :edit, :id => characters(:one).to_param

    assert_redirected_to :controller => "users", :action => "sign_in"
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]

    # can't edit other users' characters
    sign_in(users(:one))

    get :edit, :id => characters(:two).to_param

    assert_redirected_to character_path(characters(:two))
    assert_equal "You don't have permission to do that", flash[:notice]
  end

  test "should update character" do
    # ST can update all characters
    sign_in(users(:Storyteller))
    
    put :update, :id => characters(:two).to_param, :character => {:name => "newname", :virtue => "Charity", :splat_id => "1", :vice => "Envy", :nature_id => "1", :clique_id => "1", :ideology_id => "1", :read_name => "0", :read_clique => "0", :read_nature => "0", :read_ideology => "0", :description => "", :read_description => "0", :background => "", :read_background => "0", :deeds => "", :read_deeds => "1", :intelligence => "1", :strength => "1", :presence => "1", :wits => "1", :dexterity => "1", :manipulation => "1", :resolve => "1", :stamina => "1", :composure => "1", :read_attributes => "0", :academics => "0", :athletics => "0", :animal_ken => "0", :computer => "0", :brawl => "0", :empathy => "0", :crafts => "0", :drive => "0", :expression => "0", :investigation => "0", :firearms => "0", :intimidation => "0", :medicine => "0", :larceny => "0", :persuasion => "0", :occult => "0", :stealth => "0", :socialize => "0", :politics => "0", :survival => "0", :streetwise => "0", :science => "0", :weaponry => "0", :subterfuge => "0", :skill_specialties => "", :read_skills => "0", :health => "6", :willpower => "2", :derangements => "", :size => "5", :initiative => "2", :speed => "5", :defense => "1", :armor => "0", :morality => "7", :power_stat => "1", :max_fuel => "7", :current_fuel => "1", :read_advantages => "0", :merits => "", :read_merits => "0", :equipment => "", :read_equipment => "0", :death => "0", :fate => "0", :common_spells => "", :forces => "0", :life => "0", :matter => "0", :mind => "0", :prime => "0", :space => "0", :spirit => "0", :time => "0", :purity => "0", :glory => "0", :gifts => "", :honor => "0", :wisdom => "0", :cunning => "0", :animalism => "0", :auspex => "0", :covenant_disciplines => "", :celerity => "0", :dominate => "0", :majesty => "0", :nightmare => "0", :protean => "0", :obfuscate => "0", :vigor => "0", :transmutations => "", :dream => "0", :hearth => "0", :goblin_contracts => "", :mirror => "0", :smoke => "0", :artifice => "0", :darkness => "0", :elements => "0", :fang_and_tooth => "0", :stone => "0", :vainglory => "0", :fleeting_spring => "0", :eternal_spring => "0", :fleeting_summer => "0", :eternal_summer => "0", :fleeting_autumn => "0", :eternal_autumn => "0", :fleeting_winter => "0", :eternal_winter => "0", :boneyard => "0", :caul => "0", :keys => "", :curse => "0", :oracle => "0", :marionette => "0", :rage => "0", :shroud => "0", :ceremonies => "", :read_powers => "0", :experience => "", :read_experience => "0", :splat_id => "1"}
    assert_redirected_to character_path(assigns(:character))
    assert_equal("newname", Character.find_by_id(characters(:two).id).name, "didn't update as storyteller")
    
    # update own characters
    sign_in(users(:one))
    
    put :update, :id => characters(:one).to_param, :character => {:name => "newername", :virtue => "Charity", :splat_id => "1", :vice => "Envy", :nature_id => "1", :clique_id => "1", :ideology_id => "1", :read_name => "0", :read_clique => "0", :read_nature => "0", :read_ideology => "0", :description => "", :read_description => "0", :background => "", :read_background => "0", :deeds => "", :read_deeds => "1", :intelligence => "1", :strength => "1", :presence => "1", :wits => "1", :dexterity => "1", :manipulation => "1", :resolve => "1", :stamina => "1", :composure => "1", :read_attributes => "0", :academics => "0", :athletics => "0", :animal_ken => "0", :computer => "0", :brawl => "0", :empathy => "0", :crafts => "0", :drive => "0", :expression => "0", :investigation => "0", :firearms => "0", :intimidation => "0", :medicine => "0", :larceny => "0", :persuasion => "0", :occult => "0", :stealth => "0", :socialize => "0", :politics => "0", :survival => "0", :streetwise => "0", :science => "0", :weaponry => "0", :subterfuge => "0", :skill_specialties => "", :read_skills => "0", :health => "6", :willpower => "2", :derangements => "", :size => "5", :initiative => "2", :speed => "5", :defense => "1", :armor => "0", :morality => "7", :power_stat => "1", :max_fuel => "7", :current_fuel => "1", :read_advantages => "0", :merits => "", :read_merits => "0", :equipment => "", :read_equipment => "0", :death => "0", :fate => "0", :common_spells => "", :forces => "0", :life => "0", :matter => "0", :mind => "0", :prime => "0", :space => "0", :spirit => "0", :time => "0", :purity => "0", :glory => "0", :gifts => "", :honor => "0", :wisdom => "0", :cunning => "0", :animalism => "0", :auspex => "0", :covenant_disciplines => "", :celerity => "0", :dominate => "0", :majesty => "0", :nightmare => "0", :protean => "0", :obfuscate => "0", :vigor => "0", :transmutations => "", :dream => "0", :hearth => "0", :goblin_contracts => "", :mirror => "0", :smoke => "0", :artifice => "0", :darkness => "0", :elements => "0", :fang_and_tooth => "0", :stone => "0", :vainglory => "0", :fleeting_spring => "0", :eternal_spring => "0", :fleeting_summer => "0", :eternal_summer => "0", :fleeting_autumn => "0", :eternal_autumn => "0", :fleeting_winter => "0", :eternal_winter => "0", :boneyard => "0", :caul => "0", :keys => "", :curse => "0", :oracle => "0", :marionette => "0", :rage => "0", :shroud => "0", :ceremonies => "", :read_powers => "0", :experience => "", :read_experience => "0", :splat_id => "1"}
    assert_redirected_to character_path(assigns(:character))
    assert_equal("newername", Character.find_by_id(characters(:one).id).name, "didn't update own user")
  end

  test "shouldn't update character" do
    # not logged in    
    put :update, :id => characters(:one).to_param, :character => {:name => "newname", :virtue => "Charity", :splat_id => "1", :vice => "Envy", :nature_id => "1", :clique_id => "1", :ideology_id => "1", :read_name => "0", :read_clique => "0", :read_nature => "0", :read_ideology => "0", :description => "", :read_description => "0", :background => "", :read_background => "0", :deeds => "", :read_deeds => "1", :intelligence => "1", :strength => "1", :presence => "1", :wits => "1", :dexterity => "1", :manipulation => "1", :resolve => "1", :stamina => "1", :composure => "1", :read_attributes => "0", :academics => "0", :athletics => "0", :animal_ken => "0", :computer => "0", :brawl => "0", :empathy => "0", :crafts => "0", :drive => "0", :expression => "0", :investigation => "0", :firearms => "0", :intimidation => "0", :medicine => "0", :larceny => "0", :persuasion => "0", :occult => "0", :stealth => "0", :socialize => "0", :politics => "0", :survival => "0", :streetwise => "0", :science => "0", :weaponry => "0", :subterfuge => "0", :skill_specialties => "", :read_skills => "0", :health => "6", :willpower => "2", :derangements => "", :size => "5", :initiative => "2", :speed => "5", :defense => "1", :armor => "0", :morality => "7", :power_stat => "1", :max_fuel => "7", :current_fuel => "1", :read_advantages => "0", :merits => "", :read_merits => "0", :equipment => "", :read_equipment => "0", :death => "0", :fate => "0", :common_spells => "", :forces => "0", :life => "0", :matter => "0", :mind => "0", :prime => "0", :space => "0", :spirit => "0", :time => "0", :purity => "0", :glory => "0", :gifts => "", :honor => "0", :wisdom => "0", :cunning => "0", :animalism => "0", :auspex => "0", :covenant_disciplines => "", :celerity => "0", :dominate => "0", :majesty => "0", :nightmare => "0", :protean => "0", :obfuscate => "0", :vigor => "0", :transmutations => "", :dream => "0", :hearth => "0", :goblin_contracts => "", :mirror => "0", :smoke => "0", :artifice => "0", :darkness => "0", :elements => "0", :fang_and_tooth => "0", :stone => "0", :vainglory => "0", :fleeting_spring => "0", :eternal_spring => "0", :fleeting_summer => "0", :eternal_summer => "0", :fleeting_autumn => "0", :eternal_autumn => "0", :fleeting_winter => "0", :eternal_winter => "0", :boneyard => "0", :caul => "0", :keys => "", :curse => "0", :oracle => "0", :marionette => "0", :rage => "0", :shroud => "0", :ceremonies => "", :read_powers => "0", :experience => "", :read_experience => "0", :splat_id => "1"}
    assert_redirected_to :controller => "users", :action => "sign_in"
    assert_equal("You need to sign in or sign up before continuing.", flash[:alert])
    assert_not_equal("newname", Character.find_by_id(characters(:one).id).name, "updated when not logged in")
    
    # can't update others' characters
    sign_in(users(:one))
    
    put :update, :id => characters(:two).to_param, :character => {:name => "newername", :virtue => "Charity", :splat_id => "1", :vice => "Envy", :nature_id => "1", :clique_id => "1", :ideology_id => "1", :read_name => "0", :read_clique => "0", :read_nature => "0", :read_ideology => "0", :description => "", :read_description => "0", :background => "", :read_background => "0", :deeds => "", :read_deeds => "1", :intelligence => "1", :strength => "1", :presence => "1", :wits => "1", :dexterity => "1", :manipulation => "1", :resolve => "1", :stamina => "1", :composure => "1", :read_attributes => "0", :academics => "0", :athletics => "0", :animal_ken => "0", :computer => "0", :brawl => "0", :empathy => "0", :crafts => "0", :drive => "0", :expression => "0", :investigation => "0", :firearms => "0", :intimidation => "0", :medicine => "0", :larceny => "0", :persuasion => "0", :occult => "0", :stealth => "0", :socialize => "0", :politics => "0", :survival => "0", :streetwise => "0", :science => "0", :weaponry => "0", :subterfuge => "0", :skill_specialties => "", :read_skills => "0", :health => "6", :willpower => "2", :derangements => "", :size => "5", :initiative => "2", :speed => "5", :defense => "1", :armor => "0", :morality => "7", :power_stat => "1", :max_fuel => "7", :current_fuel => "1", :read_advantages => "0", :merits => "", :read_merits => "0", :equipment => "", :read_equipment => "0", :death => "0", :fate => "0", :common_spells => "", :forces => "0", :life => "0", :matter => "0", :mind => "0", :prime => "0", :space => "0", :spirit => "0", :time => "0", :purity => "0", :glory => "0", :gifts => "", :honor => "0", :wisdom => "0", :cunning => "0", :animalism => "0", :auspex => "0", :covenant_disciplines => "", :celerity => "0", :dominate => "0", :majesty => "0", :nightmare => "0", :protean => "0", :obfuscate => "0", :vigor => "0", :transmutations => "", :dream => "0", :hearth => "0", :goblin_contracts => "", :mirror => "0", :smoke => "0", :artifice => "0", :darkness => "0", :elements => "0", :fang_and_tooth => "0", :stone => "0", :vainglory => "0", :fleeting_spring => "0", :eternal_spring => "0", :fleeting_summer => "0", :eternal_summer => "0", :fleeting_autumn => "0", :eternal_autumn => "0", :fleeting_winter => "0", :eternal_winter => "0", :boneyard => "0", :caul => "0", :keys => "", :curse => "0", :oracle => "0", :marionette => "0", :rage => "0", :shroud => "0", :ceremonies => "", :read_powers => "0", :experience => "", :read_experience => "0", :splat_id => "1"}
    assert_redirected_to character_path(assigns(:character))
    assert_not_equal("newername", Character.find_by_id(characters(:two).id).name, "updated other user's character")
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
  end
  
  test "shouldn't destroy character" do
    # not logged in
    assert_no_difference "Character.count", "destroyed when not logged in" do
      delete :destroy, :id => characters(:one).to_param
    end
      assert_redirected_to :controller => "users", :action => "sign_in"
      assert_equal("You need to sign in or sign up before continuing.", flash[:alert])
    
    # can't destroy other users' characters
    sign_in(users(:one))
    
    assert_no_difference "Character.count", "removed another user's character" do
      delete :destroy, :id => characters(:two).to_param
    end
    assert_redirected_to character_path(users(:two))
    assert_equal("You don't have permission to do that", flash[:notice])
  end
end
