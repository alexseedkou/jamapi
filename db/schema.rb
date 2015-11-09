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

ActiveRecord::Schema.define(version: 20151109163941) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "lyrics_sets", force: :cascade do |t|
    t.string   "times",                   array: true
    t.string   "lyrics",                  array: true
    t.integer  "upvotes"
    t.integer  "downvotes"
    t.integer  "song_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "lyrics_sets", ["song_id"], name: "index_lyrics_sets_on_song_id", using: :btree
  add_index "lyrics_sets", ["user_id"], name: "index_lyrics_sets_on_user_id", using: :btree

  create_table "songs", force: :cascade do |t|
    t.string   "title"
    t.string   "artist"
    t.string   "album"
    t.float    "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "songs", ["artist"], name: "index_songs_on_artist", using: :btree
  add_index "songs", ["title"], name: "index_songs_on_title", using: :btree

  create_table "tabs_sets", force: :cascade do |t|
    t.string   "tuning"
    t.integer  "capo"
    t.string   "times",                               array: true
    t.string   "chords",                              array: true
    t.string   "tabs",                                array: true
    t.integer  "upvotes",    default: 0
    t.integer  "downvotes",  default: 0
    t.integer  "song_id"
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "tabs_sets", ["song_id"], name: "index_tabs_sets_on_song_id", using: :btree
  add_index "tabs_sets", ["user_id"], name: "index_tabs_sets_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "username"
    t.string   "auth_token"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

  add_foreign_key "lyrics_sets", "songs"
  add_foreign_key "lyrics_sets", "users"
  add_foreign_key "tabs_sets", "songs"
  add_foreign_key "tabs_sets", "users"
end
