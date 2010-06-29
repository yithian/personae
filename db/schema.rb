# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100629141451) do

  create_table "characters", :force => true do |t|
    t.string   "name"
    t.string   "virtue"
    t.string   "vice"
    t.integer  "clique_id",                            :null => false
    t.integer  "ideology_id",                          :null => false
    t.text     "description"
    t.text     "background"
    t.integer  "intelligence",      :default => 1
    t.integer  "strength",          :default => 1
    t.integer  "presence",          :default => 1
    t.integer  "wits",              :default => 1
    t.integer  "dexterity",         :default => 1
    t.integer  "manipulation",      :default => 1
    t.integer  "resolve",           :default => 1
    t.integer  "stamina",           :default => 1
    t.integer  "composure",         :default => 1
    t.integer  "academics",         :default => 0
    t.integer  "athletics",         :default => 0
    t.integer  "animal_ken",        :default => 0
    t.integer  "computer",          :default => 0
    t.integer  "brawl",             :default => 0
    t.integer  "empathy",           :default => 0
    t.integer  "crafts",            :default => 0
    t.integer  "drive",             :default => 0
    t.integer  "expression",        :default => 0
    t.integer  "investigation",     :default => 0
    t.integer  "firearms",          :default => 0
    t.integer  "intimidation",      :default => 0
    t.integer  "medicine",          :default => 0
    t.integer  "larceny",           :default => 0
    t.integer  "persuasion",        :default => 0
    t.integer  "occult",            :default => 0
    t.integer  "stealth",           :default => 0
    t.integer  "socialize",         :default => 0
    t.integer  "politics",          :default => 0
    t.integer  "survival",          :default => 0
    t.integer  "streetwise",        :default => 0
    t.integer  "science",           :default => 0
    t.integer  "weaponry",          :default => 0
    t.integer  "subterfuge",        :default => 0
    t.text     "skill_specialties"
    t.string   "health",            :default => "6"
    t.string   "willpower",         :default => "2"
    t.integer  "speed",             :default => 5
    t.integer  "initiative",        :default => 2
    t.integer  "defense",           :default => 1
    t.integer  "armor"
    t.integer  "morality",          :default => 7
    t.text     "derangements"
    t.text     "merits"
    t.integer  "power_stat",        :default => 1
    t.integer  "death"
    t.integer  "fate"
    t.integer  "forces"
    t.integer  "life"
    t.integer  "matter"
    t.integer  "mind"
    t.integer  "prime"
    t.integer  "space"
    t.integer  "spirit"
    t.integer  "time"
    t.text     "equipment"
    t.text     "common_spells"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "read_name",         :default => false
    t.boolean  "read_description",  :default => false
    t.boolean  "read_background",   :default => false
    t.boolean  "read_attributes",   :default => false
    t.boolean  "read_skills",       :default => false
    t.boolean  "read_advantages",   :default => false
    t.boolean  "read_merits",       :default => false
    t.boolean  "read_powers",       :default => false
    t.boolean  "read_equipment",    :default => false
    t.integer  "fuel",              :default => 7
    t.text     "experience"
    t.boolean  "read_experience",   :default => false
    t.boolean  "read_clique",       :default => false
    t.boolean  "read_ideology",     :default => false
    t.boolean  "read_nature",       :default => false
    t.integer  "splat_id",          :default => 1,     :null => false
    t.integer  "purity",            :default => 0
    t.integer  "glory",             :default => 0
    t.integer  "honor",             :default => 0
    t.integer  "wisdom",            :default => 0
    t.integer  "cunning",           :default => 0
    t.text     "gifts"
    t.text     "totem"
    t.integer  "nature_id",         :default => 1,     :null => false
  end

  create_table "cliques", :force => true do |t|
    t.string   "name"
    t.string   "territory"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "write",       :default => false
    t.integer  "user_id",     :default => 1,     :null => false
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
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "selected_character"
  end

end
