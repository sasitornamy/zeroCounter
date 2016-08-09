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

ActiveRecord::Schema.define(version: 20160728113939) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "experiment_sessions", force: :cascade do |t|
    t.datetime "started_at"
    t.integer  "user_id"
    t.text     "mechanical_turk_id"
    t.integer  "number_of_trials"
    t.boolean  "consent_given"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "stimuli", force: :cascade do |t|
    t.integer  "number_of_digits"
    t.integer  "number_of_zeros"
    t.text     "image_path"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "trials", force: :cascade do |t|
    t.integer  "experiment_session_id"
    t.integer  "stimulus_id"
    t.integer  "order_appeared"
    t.integer  "response"
    t.boolean  "response_result"
    t.integer  "response_time"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
