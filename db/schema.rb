# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110603162205) do

  create_table "characters", :force => true do |t|
    t.string   "name"
    t.string   "virtue",                              :default => "Charity"
    t.string   "vice",                                :default => "Envy"
    t.integer  "clique_id",                           :default => 1,         :null => false
    t.integer  "ideology_id",                         :default => 1,         :null => false
    t.text     "description"
    t.text     "background"
    t.integer  "intelligence",                        :default => 1
    t.integer  "strength",                            :default => 1
    t.integer  "presence",                            :default => 1
    t.integer  "wits",                                :default => 1
    t.integer  "dexterity",                           :default => 1
    t.integer  "manipulation",                        :default => 1
    t.integer  "resolve",                             :default => 1
    t.integer  "stamina",                             :default => 1
    t.integer  "composure",                           :default => 1
    t.integer  "academics",                           :default => 0
    t.integer  "athletics",                           :default => 0
    t.integer  "animal_ken",                          :default => 0
    t.integer  "computer",                            :default => 0
    t.integer  "brawl",                               :default => 0
    t.integer  "empathy",                             :default => 0
    t.integer  "crafts",                              :default => 0
    t.integer  "drive",                               :default => 0
    t.integer  "expression",                          :default => 0
    t.integer  "investigation",                       :default => 0
    t.integer  "firearms",                            :default => 0
    t.integer  "intimidation",                        :default => 0
    t.integer  "medicine",                            :default => 0
    t.integer  "larceny",                             :default => 0
    t.integer  "persuasion",                          :default => 0
    t.integer  "occult",                              :default => 0
    t.integer  "stealth",                             :default => 0
    t.integer  "socialize",                           :default => 0
    t.integer  "politics",                            :default => 0
    t.integer  "survival",                            :default => 0
    t.integer  "streetwise",                          :default => 0
    t.integer  "science",                             :default => 0
    t.integer  "weaponry",                            :default => 0
    t.integer  "subterfuge",                          :default => 0
    t.text     "skill_specialties"
    t.integer  "health",               :limit => 255, :default => 6
    t.integer  "willpower",            :limit => 255, :default => 2
    t.integer  "speed",                               :default => 7
    t.integer  "initiative",                          :default => 2
    t.integer  "defense",                             :default => 1
    t.integer  "armor",                               :default => 0
    t.integer  "morality",                            :default => 7
    t.text     "derangements"
    t.text     "merits"
    t.integer  "power_stat",                          :default => 1
    t.integer  "death",                               :default => 0
    t.integer  "fate",                                :default => 0
    t.integer  "forces",                              :default => 0
    t.integer  "life",                                :default => 0
    t.integer  "matter",                              :default => 0
    t.integer  "mind",                                :default => 0
    t.integer  "prime",                               :default => 0
    t.integer  "space",                               :default => 0
    t.integer  "spirit",                              :default => 0
    t.integer  "time",                                :default => 0
    t.text     "equipment"
    t.text     "common_spells"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",                             :default => 1
    t.boolean  "read_name",                           :default => false
    t.boolean  "read_description",                    :default => false
    t.boolean  "read_background",                     :default => false
    t.boolean  "read_attributes",                     :default => false
    t.boolean  "read_skills",                         :default => false
    t.boolean  "read_advantages",                     :default => false
    t.boolean  "read_merits",                         :default => false
    t.boolean  "read_powers",                         :default => false
    t.boolean  "read_equipment",                      :default => false
    t.integer  "max_fuel",                            :default => 7
    t.text     "experience"
    t.boolean  "read_experience",                     :default => false
    t.boolean  "read_clique",                         :default => false
    t.boolean  "read_ideology",                       :default => false
    t.boolean  "read_nature",                         :default => false
    t.integer  "splat_id",                            :default => 1,         :null => false
    t.integer  "purity",                              :default => 0
    t.integer  "glory",                               :default => 0
    t.integer  "honor",                               :default => 0
    t.integer  "wisdom",                              :default => 0
    t.integer  "cunning",                             :default => 0
    t.text     "gifts"
    t.integer  "nature_id",                           :default => 1,         :null => false
    t.integer  "animalism",                           :default => 0
    t.integer  "auspex",                              :default => 0
    t.integer  "celerity",                            :default => 0
    t.integer  "dominate",                            :default => 0
    t.integer  "majesty",                             :default => 0
    t.integer  "nightmare",                           :default => 0
    t.integer  "protean",                             :default => 0
    t.integer  "obfuscate",                           :default => 0
    t.integer  "vigor",                               :default => 0
    t.text     "covenant_disciplines"
    t.integer  "size",                                :default => 5,         :null => false
    t.text     "transmutations"
    t.integer  "dream",                               :default => 0,         :null => false
    t.integer  "hearth",                              :default => 0,         :null => false
    t.integer  "mirror",                              :default => 0,         :null => false
    t.integer  "smoke",                               :default => 0,         :null => false
    t.integer  "artifice",                            :default => 0,         :null => false
    t.integer  "darkness",                            :default => 0,         :null => false
    t.integer  "elements",                            :default => 0,         :null => false
    t.integer  "fang_and_tooth",                      :default => 0,         :null => false
    t.integer  "stone",                               :default => 0,         :null => false
    t.integer  "vainglory",                           :default => 0,         :null => false
    t.integer  "fleeting_spring",                     :default => 0,         :null => false
    t.integer  "eternal_spring",                      :default => 0,         :null => false
    t.integer  "fleeting_summer",                     :default => 0,         :null => false
    t.integer  "eternal_summer",                      :default => 0,         :null => false
    t.integer  "fleeting_autumn",                     :default => 0,         :null => false
    t.integer  "eternal_autumn",                      :default => 0,         :null => false
    t.integer  "fleeting_winter",                     :default => 0,         :null => false
    t.integer  "eternal_winter",                      :default => 0,         :null => false
    t.text     "goblin_contracts"
    t.text     "pledges"
    t.integer  "boneyard",                            :default => 0,         :null => false
    t.integer  "caul",                                :default => 0,         :null => false
    t.integer  "curse",                               :default => 0,         :null => false
    t.integer  "marionette",                          :default => 0,         :null => false
    t.integer  "oracle",                              :default => 0,         :null => false
    t.integer  "rage",                                :default => 0,         :null => false
    t.integer  "shroud",                              :default => 0,         :null => false
    t.text     "keys"
    t.text     "ceremonies"
    t.text     "deeds"
    t.boolean  "read_deeds",                          :default => true
    t.string   "current_health"
    t.string   "current_willpower"
    t.text     "notes"
    t.boolean  "read_notes",                          :default => false
    t.integer  "chronicle_id",                        :default => 1
    t.integer  "subnature_id",                        :default => 1,         :null => false
    t.integer  "resilience",                          :default => 0,         :null => false
    t.integer  "current_fuel",                        :default => 7
  end

  create_table "chronicles", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",     :default => 1, :null => false
  end

  create_table "cliques", :force => true do |t|
    t.string   "name"
    t.string   "territory"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "write",        :default => false
    t.integer  "user_id",      :default => 1,     :null => false
    t.integer  "chronicle_id", :default => 1
    t.text     "totem"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "character_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "speaker"
  end

  create_table "ideologies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "splat_id",   :default => 1, :null => false
  end

  create_table "natures", :force => true do |t|
    t.string  "name"
    t.integer "splat_id", :default => 1, :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "splats", :force => true do |t|
    t.string   "name"
    t.string   "nature_name"
    t.string   "clique_name"
    t.string   "ideology_name"
    t.string   "morality_name"
    t.string   "power_stat_name"
    t.string   "fuel_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subnature_name"
  end

  create_table "subnatures", :force => true do |t|
    t.string   "name"
    t.integer  "nature_id",  :default => 1, :null => false
    t.integer  "splat_id",   :default => 1, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "selected_character"
    t.string   "email_address"
    t.string   "reset_code"
    t.integer  "selected_chronicle_id", :default => 1, :null => false
  end

end
