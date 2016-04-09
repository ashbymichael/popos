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

ActiveRecord::Schema.define(version: 20160409220539) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.string   "front"
    t.string   "back"
    t.datetime "due"
    t.integer  "deck_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "interval"
    t.float    "efactor"
    t.integer  "repetition"
    t.string   "status"
  end

  add_index "cards", ["deck_id"], name: "index_cards_on_deck_id", using: :btree

  create_table "decks", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "decks", ["user_id"], name: "index_decks_on_user_id", using: :btree

  create_table "popos", force: :cascade do |t|
    t.string   "name"
    t.float    "lat"
    t.float    "long"
    t.string   "restrooms"
    t.string   "address"
    t.string   "image"
    t.text     "description"
    t.string   "hours"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "location"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "cards", "decks"
  add_foreign_key "decks", "users"
end
