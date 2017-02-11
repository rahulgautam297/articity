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

ActiveRecord::Schema.define(version: 20170211054209) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "language_users", force: :cascade do |t|
    t.integer  "language_id"
    t.integer  "user_id"
    t.integer  "level",       default: 1
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["language_id"], name: "index_language_users_on_language_id", using: :btree
    t.index ["user_id"], name: "index_language_users_on_user_id", using: :btree
  end

  create_table "languages", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skill_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string   "name",                                                  null: false
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.integer  "skill_category_id"
    t.string   "description",       default: "Please add description."
    t.index ["skill_category_id"], name: "index_skills_on_skill_category_id", using: :btree
  end

  create_table "user_skills", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.integer  "skill_id",    null: false
    t.string   "description", null: false
    t.string   "price",       null: false
    t.string   "portfolio"
    t.string   "multimedia"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["skill_id"], name: "index_user_skills_on_skill_id", using: :btree
    t.index ["user_id"], name: "index_user_skills_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "mobile"
    t.string   "picture"
    t.text     "description"
    t.string   "portfolio"
    t.string   "college"
    t.text     "address"
    t.string   "locality"
    t.string   "state"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["mobile"], name: "index_users_on_mobile", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "language_users", "languages"
  add_foreign_key "language_users", "users"
  add_foreign_key "skills", "skill_categories"
  add_foreign_key "user_skills", "skills"
  add_foreign_key "user_skills", "users"
end
