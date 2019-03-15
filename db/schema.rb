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

ActiveRecord::Schema.define(version: 2019_03_14_232602) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.text "name"
    t.datetime "date"
    t.text "where"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
  end

  create_table "games", force: :cascade do |t|
    t.text "name"
    t.integer "min_players"
    t.integer "max_players"
    t.text "bgg_link"
    t.integer "duration_secs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "event_id", null: false
    t.bigint "suggestor_id", null: false
    t.string "bgg_id"
    t.text "pitch"
    t.index ["event_id"], name: "index_games_on_event_id"
    t.index ["suggestor_id"], name: "index_games_on_suggestor_id"
  end

  create_table "interests", force: :cascade do |t|
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "game_id", null: false
    t.bigint "user_id", null: false
    t.boolean "can_teach", default: false
    t.index ["game_id"], name: "index_interests_on_game_id"
    t.index ["user_id", "game_id"], name: "index_interests_on_user_id_and_game_id", unique: true
    t.index ["user_id"], name: "index_interests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "bgg_username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "games", "events"
  add_foreign_key "games", "users", column: "suggestor_id"
  add_foreign_key "interests", "games"
  add_foreign_key "interests", "users"
end
