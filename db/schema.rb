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

ActiveRecord::Schema.define(version: 20160126231011) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "lyrics_sets", force: :cascade do |t|
    t.string   "times",                                              array: true
    t.string   "lyrics",                                             array: true
    t.integer  "song_id"
    t.integer  "user_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
    t.datetime "last_edited"
    t.boolean  "visible"
  end

  add_index "lyrics_sets", ["cached_votes_down"], name: "index_lyrics_sets_on_cached_votes_down", using: :btree
  add_index "lyrics_sets", ["cached_votes_score"], name: "index_lyrics_sets_on_cached_votes_score", using: :btree
  add_index "lyrics_sets", ["cached_votes_total"], name: "index_lyrics_sets_on_cached_votes_total", using: :btree
  add_index "lyrics_sets", ["cached_votes_up"], name: "index_lyrics_sets_on_cached_votes_up", using: :btree
  add_index "lyrics_sets", ["cached_weighted_average"], name: "index_lyrics_sets_on_cached_weighted_average", using: :btree
  add_index "lyrics_sets", ["cached_weighted_score"], name: "index_lyrics_sets_on_cached_weighted_score", using: :btree
  add_index "lyrics_sets", ["cached_weighted_total"], name: "index_lyrics_sets_on_cached_weighted_total", using: :btree
  add_index "lyrics_sets", ["song_id"], name: "index_lyrics_sets_on_song_id", using: :btree
  add_index "lyrics_sets", ["user_id"], name: "index_lyrics_sets_on_user_id", using: :btree

  create_table "songs", force: :cascade do |t|
    t.string   "title"
    t.string   "artist"
    t.string   "album",          default: ""
    t.float    "duration"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "total_score",    default: 0
    t.string   "soundwave_url",  default: ""
    t.boolean  "in_iTunes",      default: false
    t.string   "title_aliases",  default: ""
    t.string   "artist_aliases", default: ""
    t.integer  "track_id",       default: 0
    t.string   "artwork_url",    default: ""
    t.string   "preview_url",    default: ""
    t.string   "store_link",     default: ""
    t.integer  "set_scores",     default: [],                 array: true
  end

  add_index "songs", ["artist"], name: "index_songs_on_artist", using: :btree
  add_index "songs", ["title"], name: "index_songs_on_title", using: :btree

  create_table "tabs_sets", force: :cascade do |t|
    t.string   "tuning"
    t.integer  "capo"
    t.string   "times",                                              array: true
    t.string   "chords",                                             array: true
    t.string   "tabs",                                               array: true
    t.integer  "song_id"
    t.integer  "user_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
    t.datetime "last_edited"
    t.boolean  "visible"
  end

  add_index "tabs_sets", ["cached_votes_down"], name: "index_tabs_sets_on_cached_votes_down", using: :btree
  add_index "tabs_sets", ["cached_votes_score"], name: "index_tabs_sets_on_cached_votes_score", using: :btree
  add_index "tabs_sets", ["cached_votes_total"], name: "index_tabs_sets_on_cached_votes_total", using: :btree
  add_index "tabs_sets", ["cached_votes_up"], name: "index_tabs_sets_on_cached_votes_up", using: :btree
  add_index "tabs_sets", ["cached_weighted_average"], name: "index_tabs_sets_on_cached_weighted_average", using: :btree
  add_index "tabs_sets", ["cached_weighted_score"], name: "index_tabs_sets_on_cached_weighted_score", using: :btree
  add_index "tabs_sets", ["cached_weighted_total"], name: "index_tabs_sets_on_cached_weighted_total", using: :btree
  add_index "tabs_sets", ["song_id"], name: "index_tabs_sets_on_song_id", using: :btree
  add_index "tabs_sets", ["user_id"], name: "index_tabs_sets_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "nickname",               default: ""
    t.string   "auth_token"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "password_digest"
    t.string   "avatar_url_medium",      default: ""
    t.string   "avatar_url_thumbnail",   default: ""
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

  add_foreign_key "lyrics_sets", "songs"
  add_foreign_key "lyrics_sets", "users"
  add_foreign_key "tabs_sets", "songs"
  add_foreign_key "tabs_sets", "users"
end
