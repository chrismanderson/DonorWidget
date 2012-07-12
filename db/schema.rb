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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120712143948) do

  create_table "projects", :force => true do |t|
    t.integer  "pid"
    t.string   "proposal_url"
    t.string   "fund_url"
    t.string   "image_url"
    t.string   "title"
    t.string   "short_description"
    t.string   "fulfillment_trailer"
    t.integer  "percent_funded"
    t.decimal  "cost_to_complete"
    t.decimal  "total_price"
    t.string   "teacher_name"
    t.string   "grade_level"
    t.string   "poverty_level"
    t.string   "school"
    t.string   "city"
    t.integer  "zip"
    t.string   "state"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.string   "subject"
    t.string   "resource"
    t.datetime "expiration_date"
    t.string   "funding_status"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "encrypted_password"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "widgets", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.string   "background_color"
    t.string   "size"
    t.string   "rollover_method"
    t.boolean  "archived"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

end
