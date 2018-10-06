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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 2018_10_13_003738) do
=======
ActiveRecord::Schema.define(version: 2018_10_05_204253) do
>>>>>>> Pressao Sanguinea - new, edit, delete

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

<<<<<<< HEAD
  create_table "heights", force: :cascade do |t|
    t.decimal "value"
    t.date "date"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_heights_on_profile_id"
=======
  create_table "pressures", force: :cascade do |t|
    t.integer "sis"
    t.integer "dia"
    t.datetime "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
>>>>>>> Pressao Sanguinea - new, edit, delete
  end

  create_table "profiles", force: :cascade do |t|
    t.string "email"
    t.string "firstname"
    t.string "lastname"
    t.date "birthdate"
    t.string "sex"
    t.string "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

<<<<<<< HEAD
  create_table "weights", force: :cascade do |t|
    t.decimal "value"
    t.date "date"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_weights_on_profile_id"
  end

  add_foreign_key "heights", "profiles"
  add_foreign_key "weights", "profiles"
=======
>>>>>>> Pressao Sanguinea - new, edit, delete
end
