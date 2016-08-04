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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130327005313) do

  create_table "characters", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.string   "virtue",                              default: "Charity"
    t.string   "vice",                                default: "Envy"
    t.integer  "clique_id",                           default: 6,         null: false
    t.integer  "ideology_id",                         default: 1,         null: false
    t.text     "description",           limit: 65535
    t.text     "background",            limit: 65535
    t.integer  "intelligence",                        default: 1
    t.integer  "strength",                            default: 1
    t.integer  "presence",                            default: 1
    t.integer  "wits",                                default: 1
    t.integer  "dexterity",                           default: 1
    t.integer  "manipulation",                        default: 1
    t.integer  "resolve",                             default: 1
    t.integer  "stamina",                             default: 1
    t.integer  "composure",                           default: 1
    t.integer  "academics",                           default: 0
    t.integer  "athletics",                           default: 0
    t.integer  "animal_ken",                          default: 0
    t.integer  "computer",                            default: 0
    t.integer  "brawl",                               default: 0
    t.integer  "empathy",                             default: 0
    t.integer  "crafts",                              default: 0
    t.integer  "drive",                               default: 0
    t.integer  "expression",                          default: 0
    t.integer  "investigation",                       default: 0
    t.integer  "firearms",                            default: 0
    t.integer  "intimidation",                        default: 0
    t.integer  "medicine",                            default: 0
    t.integer  "larceny",                             default: 0
    t.integer  "persuasion",                          default: 0
    t.integer  "occult",                              default: 0
    t.integer  "stealth",                             default: 0
    t.integer  "socialize",                           default: 0
    t.integer  "politics",                            default: 0
    t.integer  "survival",                            default: 0
    t.integer  "streetwise",                          default: 0
    t.integer  "science",                             default: 0
    t.integer  "weaponry",                            default: 0
    t.integer  "subterfuge",                          default: 0
    t.text     "skill_specialties",     limit: 65535
    t.integer  "health",                              default: 6
    t.integer  "willpower",                           default: 2
    t.integer  "speed",                               default: 7
    t.integer  "initiative",                          default: 2
    t.integer  "defense",                             default: 1
    t.integer  "armor",                               default: 0
    t.integer  "morality",                            default: 7
    t.text     "derangements",          limit: 65535
    t.text     "merits",                limit: 65535
    t.integer  "power_stat",                          default: 1
    t.integer  "death",                               default: 0
    t.integer  "fate",                                default: 0
    t.integer  "forces",                              default: 0
    t.integer  "life",                                default: 0
    t.integer  "matter",                              default: 0
    t.integer  "mind",                                default: 0
    t.integer  "prime",                               default: 0
    t.integer  "space",                               default: 0
    t.integer  "spirit",                              default: 0
    t.integer  "time",                                default: 0
    t.text     "equipment",             limit: 65535
    t.text     "common_spells",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id",                            default: 1
    t.boolean  "read_name",                           default: false
    t.boolean  "read_description",                    default: false
    t.boolean  "read_background",                     default: false
    t.boolean  "read_crunch",                         default: false
    t.integer  "max_fuel",                            default: 7
    t.text     "experience",            limit: 65535
    t.boolean  "read_experience",                     default: false
    t.boolean  "read_clique",                         default: false
    t.boolean  "read_ideology",                       default: false
    t.boolean  "read_nature",                         default: false
    t.integer  "splat_id",                            default: 1,         null: false
    t.integer  "purity",                              default: 0
    t.integer  "glory",                               default: 0
    t.integer  "honor",                               default: 0
    t.integer  "wisdom",                              default: 0
    t.integer  "cunning",                             default: 0
    t.text     "gifts",                 limit: 65535
    t.integer  "nature_id",                           default: 1,         null: false
    t.integer  "animalism",                           default: 0
    t.integer  "auspex",                              default: 0
    t.integer  "celerity",                            default: 0
    t.integer  "dominate",                            default: 0
    t.integer  "majesty",                             default: 0
    t.integer  "nightmare",                           default: 0
    t.integer  "protean",                             default: 0
    t.integer  "obfuscate",                           default: 0
    t.integer  "vigor",                               default: 0
    t.text     "covenant_disciplines",  limit: 65535
    t.integer  "size",                                default: 5,         null: false
    t.text     "transmutations",        limit: 65535
    t.integer  "dream",                               default: 0,         null: false
    t.integer  "hearth",                              default: 0,         null: false
    t.integer  "mirror",                              default: 0,         null: false
    t.integer  "smoke",                               default: 0,         null: false
    t.integer  "artifice",                            default: 0,         null: false
    t.integer  "darkness",                            default: 0,         null: false
    t.integer  "elements",                            default: 0,         null: false
    t.integer  "fang_and_tooth",                      default: 0,         null: false
    t.integer  "stone",                               default: 0,         null: false
    t.integer  "vainglory",                           default: 0,         null: false
    t.integer  "fleeting_spring",                     default: 0,         null: false
    t.integer  "eternal_spring",                      default: 0,         null: false
    t.integer  "fleeting_summer",                     default: 0,         null: false
    t.integer  "eternal_summer",                      default: 0,         null: false
    t.integer  "fleeting_autumn",                     default: 0,         null: false
    t.integer  "eternal_autumn",                      default: 0,         null: false
    t.integer  "fleeting_winter",                     default: 0,         null: false
    t.integer  "eternal_winter",                      default: 0,         null: false
    t.text     "goblin_contracts",      limit: 65535
    t.text     "pledges",               limit: 65535
    t.integer  "boneyard",                            default: 0,         null: false
    t.integer  "caul",                                default: 0,         null: false
    t.integer  "curse",                               default: 0,         null: false
    t.integer  "marionette",                          default: 0,         null: false
    t.integer  "oracle",                              default: 0,         null: false
    t.integer  "rage",                                default: 0,         null: false
    t.integer  "shroud",                              default: 0,         null: false
    t.text     "keys",                  limit: 65535
    t.text     "ceremonies",            limit: 65535
    t.text     "deeds",                 limit: 65535
    t.boolean  "read_deeds",                          default: true
    t.string   "current_health"
    t.string   "current_willpower"
    t.text     "notes",                 limit: 65535
    t.boolean  "read_notes",                          default: false
    t.integer  "chronicle_id",                        default: 1
    t.integer  "subnature_id",                        default: 1,         null: false
    t.integer  "resilience",                          default: 0,         null: false
    t.integer  "current_fuel",                        default: 7
    t.string   "obsidian_character_id"
    t.string   "concept",                             default: ""
    t.text     "tactics",               limit: 65535
    t.boolean  "pc",                                  default: false
    t.boolean  "possessed",                           default: false
    t.integer  "envy",                                default: 0
    t.integer  "gluttony",                            default: 0
    t.integer  "greed",                               default: 0
    t.integer  "lust",                                default: 0
    t.integer  "pride",                               default: 0
    t.integer  "sloth",                               default: 0
    t.integer  "wrath",                               default: 0
    t.text     "vestments",             limit: 65535
    t.string   "primary_vice"
    t.string   "current_infernal_will"
    t.integer  "power",                               default: 1
    t.integer  "finesse",                             default: 1
    t.integer  "resistance",                          default: 1
    t.text     "numina",                limit: 65535
    t.string   "influences"
    t.integer  "ab",                                  default: 0,         null: false
    t.integer  "current_ab",                          default: 0,         null: false
    t.integer  "ba",                                  default: 0,         null: false
    t.integer  "current_ba",                          default: 0,         null: false
    t.integer  "ka",                                  default: 0,         null: false
    t.integer  "current_ka",                          default: 0,         null: false
    t.integer  "ren",                                 default: 0,         null: false
    t.integer  "current_ren",                         default: 0,         null: false
    t.integer  "sheut",                               default: 0,         null: false
    t.integer  "current_sheut",                       default: 0,         null: false
    t.text     "affinities",            limit: 65535
    t.text     "utterances",            limit: 65535
    t.index ["chronicle_id"], name: "index_characters_on_chronicle_id", using: :btree
  end

  create_table "chronicles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.text     "description",          limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id",                           default: 1, null: false
    t.string   "obsidian_campaign_id"
  end

  create_table "cliques", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.string   "territory"
    t.text     "description",  limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "write",                      default: false
    t.integer  "owner_id",                   default: 1,     null: false
    t.integer  "chronicle_id",               default: 1
    t.index ["chronicle_id"], name: "index_cliques_on_chronicle_id", using: :btree
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "user_id"
    t.integer  "character_id"
    t.text     "body",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "speaker"
  end

  create_table "ideologies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "splat_id",   default: 1, null: false
  end

  create_table "natures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string  "name"
    t.integer "splat_id", default: 1, null: false
  end

  create_table "sessions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "session_id",               null: false
    t.text     "data",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "index_sessions_on_session_id", using: :btree
    t.index ["updated_at"], name: "index_sessions_on_updated_at", using: :btree
  end

  create_table "splats", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
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

  create_table "subnatures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.integer  "nature_id",  default: 1, null: false
    t.integer  "splat_id",   default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "selected_character"
    t.string   "email",                              default: "",    null: false
    t.integer  "selected_chronicle_id",              default: 1,     null: false
    t.string   "encrypted_password",     limit: 128, default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin",                              default: false
    t.string   "obsidian_user_id"
    t.string   "obsidian_user_name"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
