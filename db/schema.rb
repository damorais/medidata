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

ActiveRecord::Schema.define(version: 2019_06_11_192429) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "allergies", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cause"
    t.string "allergen"
    t.string "known_reaction"
    t.date "start"
    t.date "finish"
    t.index ["profile_id"], name: "index_allergies_on_profile_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "phone"
    t.string "mobile"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_contacts_on_profile_id"
  end

  create_table "diseases", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.date "start"
    t.date "finish"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_diseases_on_profile_id"
  end

  create_table "glucose_measures", force: :cascade do |t|
    t.float "value"
    t.datetime "date"
    t.boolean "fasting"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_glucose_measures_on_profile_id"
  end

  create_table "hdls", force: :cascade do |t|
    t.integer "value"
    t.date "date"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_hdls_on_profile_id"
  end

  create_table "health_insurances", force: :cascade do |t|
    t.string "name"
    t.string "provider"
    t.string "plan_name"
    t.string "plan_number"
    t.string "plan_type"
    t.date "start_date"
    t.date "expiration_date"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_health_insurances_on_profile_id"
  end

  create_table "heights", force: :cascade do |t|
    t.decimal "value"
    t.date "date"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_heights_on_profile_id"
  end

  create_table "ldls", force: :cascade do |t|
    t.integer "value"
    t.date "date"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_ldls_on_profile_id"
  end

  create_table "medical_appointments", force: :cascade do |t|
    t.string "specialty"
    t.text "address"
    t.datetime "date"
    t.string "professional"
    t.string "type_appointment"
    t.text "note"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_medical_appointments_on_profile_id"
  end

  create_table "medications", force: :cascade do |t|
    t.string "name"
    t.string "categorize"
    t.date "start"
    t.date "finish"
    t.string "dosage"
    t.string "infadd"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_medications_on_profile_id"
  end

  create_table "non_hdls", force: :cascade do |t|
    t.integer "value"
    t.date "date"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_non_hdls_on_profile_id"
  end

  create_table "platelets", force: :cascade do |t|
    t.decimal "erythrocyte"
    t.decimal "hemoglobin"
    t.decimal "hematocrit"
    t.decimal "vcm"
    t.decimal "hcm"
    t.decimal "chcm"
    t.decimal "rdw"
    t.decimal "leukocytep"
    t.decimal "neutrophilp"
    t.decimal "eosinophilp"
    t.decimal "basophilp"
    t.decimal "lymphocytep"
    t.decimal "monocytep"
    t.integer "leukocyteul"
    t.integer "neutrophilul"
    t.integer "eosinophilul"
    t.integer "basophilul"
    t.integer "lymphocyteul"
    t.integer "monocyteul"
    t.integer "total"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_platelets_on_profile_id"
  end

  create_table "pressures", force: :cascade do |t|
    t.integer "systolic"
    t.integer "diastolic"
    t.datetime "date"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_pressures_on_profile_id"
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
    t.bigint "user_id"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "reactions", force: :cascade do |t|
    t.string "name"
    t.string "cause"
    t.text "description"
    t.date "start"
    t.date "finish"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_reactions_on_profile_id"
  end

  create_table "relatives", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "kinship"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_relatives_on_profile_id"
  end

  create_table "totals", force: :cascade do |t|
    t.integer "value"
    t.date "date"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_totals_on_profile_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vldls", force: :cascade do |t|
    t.integer "value"
    t.date "date"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_vldls_on_profile_id"
  end

  create_table "weight_goals", force: :cascade do |t|
    t.decimal "value"
    t.date "date"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_weight_goals_on_profile_id"
  end

  create_table "weights", force: :cascade do |t|
    t.decimal "value"
    t.date "date"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_weights_on_profile_id"
  end

  add_foreign_key "allergies", "profiles"
  add_foreign_key "contacts", "profiles"
  add_foreign_key "diseases", "profiles"
  add_foreign_key "glucose_measures", "profiles"
  add_foreign_key "hdls", "profiles"
  add_foreign_key "health_insurances", "profiles"
  add_foreign_key "heights", "profiles"
  add_foreign_key "ldls", "profiles"
  add_foreign_key "medical_appointments", "profiles"
  add_foreign_key "medications", "profiles"
  add_foreign_key "non_hdls", "profiles"
  add_foreign_key "platelets", "profiles"
  add_foreign_key "pressures", "profiles"
  add_foreign_key "profiles", "users"
  add_foreign_key "reactions", "profiles"
  add_foreign_key "relatives", "profiles"
  add_foreign_key "totals", "profiles"
  add_foreign_key "vldls", "profiles"
  add_foreign_key "weight_goals", "profiles"
  add_foreign_key "weights", "profiles"
end
