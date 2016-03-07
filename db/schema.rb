# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160307003458) do

  create_table "calculators", force: :cascade do |t|
    t.integer  "eight_hundred"
    t.integer  "six_hundred"
    t.string   "discount_code"
    t.integer  "photo_package"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "playdays", force: :cascade do |t|
    t.integer  "seven_am"
    t.integer  "eight_am"
    t.integer  "nine_am"
    t.integer  "ten_am"
    t.integer  "eleven_am"
    t.integer  "twelve_pm"
    t.integer  "one_pm"
    t.integer  "two_pm"
    t.integer  "three_pm"
    t.integer  "four_pm"
    t.integer  "five_pm"
    t.integer  "six_pm"
    t.integer  "seven_pm"
    t.integer  "eight_pm"
    t.string   "date"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "slug"
    t.integer  "eight_thirty"
    t.integer  "eight_thirty_am"
    t.integer  "nine_thirty_am"
    t.integer  "ten_thirty_am"
    t.integer  "eleven_thirty_am"
    t.integer  "twelve_thirty_pm"
    t.integer  "one_thirty_pm"
    t.integer  "two_thirty_pm"
    t.integer  "three_thirty_pm"
    t.integer  "four_thirty_pm"
    t.integer  "five_thirty_pm"
    t.integer  "six_thirty_pm"
    t.integer  "seven_thirty_pm"
  end

  add_index "playdays", ["slug"], name: "index_playdays_on_slug"

  create_table "reservations", force: :cascade do |t|
    t.string   "email"
    t.integer  "six_hundred"
    t.integer  "eight_hundred"
    t.string   "date"
    t.string   "time"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "playday_id"
    t.string   "discount"
    t.integer  "user_id"
    t.integer  "photo"
    t.string   "slug"
    t.string   "comments"
    t.string   "customer_email"
    t.string   "customer_first_name"
    t.string   "customer_last_name"
    t.string   "customer_phone_number"
    t.integer  "timez"
  end

  add_index "reservations", ["playday_id"], name: "index_reservations_on_playday_id"
  add_index "reservations", ["slug"], name: "index_reservations_on_slug"
  add_index "reservations", ["user_id"], name: "index_reservations_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "firstname"
    t.string   "lastname"
    t.string   "phone"
    t.string   "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
