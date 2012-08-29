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

ActiveRecord::Schema.define(:version => 20120621025917) do

  create_table "kindeditor_assets", :force => true do |t|
    t.string   "asset"
    t.integer  "file_size"
    t.string   "file_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "lesson_hours", :force => true do |t|
    t.integer  "lesson_id",           :null => false
    t.text     "process_teacher"
    t.text     "process_stu"
    t.text     "process_idea"
    t.text     "evaluate_blackboard"
    t.text     "summary_homework"
    t.text     "thinking"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "lessons", :force => true do |t|
    t.string   "title",               :null => false
    t.text     "goal_knowledge"
    t.text     "goal_ability"
    t.text     "goal_emotion"
    t.text     "unit_emphasis"
    t.text     "teaching_emphasis"
    t.text     "teaching_difficulty"
    t.text     "teaching_method"
    t.text     "teaching_ready"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "course"
    t.string   "grade"
    t.string   "volume"
    t.string   "unit"
    t.integer  "user_id"
    t.string   "class_hour"
    t.integer  "term_id"
  end

  create_table "plans", :force => true do |t|
    t.string   "title"
    t.string   "course"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "term_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "summarizes", :force => true do |t|
    t.string   "title"
    t.string   "course"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "term_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "terms", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username",                     :null => false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
  end

  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"

end
