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

ActiveRecord::Schema.define(version: 20150616213217) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "show_date"
    t.string   "aasm_state"
  end

  create_table "seats", force: :cascade do |t|
    t.string   "row"
    t.string   "column"
    t.string   "section"
    t.string   "aasm_state"
    t.string   "name"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "event_id"
    t.float    "price",      default: 99.99
    t.integer  "level",      default: 1
  end

  create_table "tickets", force: :cascade do |t|
    t.integer  "seat_id"
    t.text     "barcode"
    t.string   "email"
    t.string   "name"
    t.datetime "scan_time"
    t.string   "aasm_state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
