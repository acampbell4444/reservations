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

ActiveRecord::Schema.define(version: 20160227005629) do

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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  add_index "playdays", ["slug"], name: "index_playdays_on_slug"

  create_table "reservations", force: :cascade do |t|
    t.string   "email"
    t.integer  "six_hundred"
    t.integer  "eight_hundred"
    t.string   "date"
    t.string   "time"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
