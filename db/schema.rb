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

ActiveRecord::Schema.define(version: 20161023125123) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "selected_tweets", force: :cascade do |t|
    t.text     "message"
    t.integer  "user_id"
    t.string   "tweet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "posted_by"
    t.string   "image_url"
    t.string   "name"
    t.datetime "tweet_at"
  end

  create_table "tweet_statuses", force: :cascade do |t|
    t.string   "status"
    t.integer  "selected_tweet_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "screen_name"
  end

  create_table "work_logs", force: :cascade do |t|
    t.text     "comment"
    t.integer  "selected_tweet_id"
    t.boolean  "has_been_tweeted"
    t.datetime "tweeted_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

end
