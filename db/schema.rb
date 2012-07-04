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

ActiveRecord::Schema.define(:version => 20120703121819) do

  create_table "attachments", :force => true do |t|
    t.boolean  "is_deleted"
    t.string   "filename"
    t.string   "content_type"
    t.integer  "size"
    t.datetime "postedOn"
    t.integer  "attached_by_id"
    t.string   "attached_by_type"
    t.integer  "attached_id"
    t.string   "attached_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "buy_and_sells", :force => true do |t|
    t.string   "locale",                            :null => false
    t.integer  "posted_by_id"
    t.string   "posted_by_type"
    t.string   "category",                          :null => false
    t.string   "subject",                           :null => false
    t.datetime "postedOn",                          :null => false
    t.integer  "valid_days",     :default => 0
    t.datetime "valid_until",                       :null => false
    t.integer  "views",          :default => 0
    t.integer  "likes",          :default => 0
    t.integer  "dislikes",       :default => 0
    t.integer  "rank",           :default => 0
    t.boolean  "abuse",          :default => false
    t.boolean  "is_deleted",     :default => false
    t.float    "price"
  end

  create_table "comments", :force => true do |t|
    t.boolean  "is_deleted",        :default => false
    t.string   "locale"
    t.text     "body"
    t.datetime "postedOn"
    t.boolean  "abuse",             :default => false
    t.integer  "commented_id"
    t.string   "commented_type"
    t.integer  "commented_by_id"
    t.string   "commented_by_type"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  create_table "contents", :force => true do |t|
    t.text     "body"
    t.integer  "contented_id"
    t.string   "contented_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "homes", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "images", :force => true do |t|
    t.boolean  "is_deleted"
    t.string   "filename"
    t.string   "content_type"
    t.integer  "size"
    t.datetime "postedOn"
    t.integer  "attached_by_id"
    t.string   "attached_by_type"
    t.integer  "attached_id"
    t.string   "attached_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "zindex"
  end

  create_table "jobs", :force => true do |t|
    t.string   "locale",                            :null => false
    t.integer  "posted_by_id"
    t.string   "posted_by_type"
    t.string   "category",                          :null => false
    t.string   "subject",                           :null => false
    t.datetime "postedOn",                          :null => false
    t.integer  "valid_days",     :default => 0
    t.datetime "valid_until",                       :null => false
    t.integer  "views",          :default => 0
    t.integer  "likes",          :default => 0
    t.integer  "dislikes",       :default => 0
    t.integer  "rank",           :default => 0
    t.boolean  "abuse",          :default => false
    t.boolean  "is_deleted",     :default => false
  end

  create_table "member_managements", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "mypages", :force => true do |t|
    t.integer  "mypagable_id"
    t.string   "mypagable_type"
    t.boolean  "is_public",      :default => false
    t.string   "public_url"
    t.integer  "blocked",        :default => 0
    t.integer  "num_of_post",    :default => 0
    t.boolean  "is_blacklist",   :default => false
    t.boolean  "nologin",        :default => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "top_feed_lists", :force => true do |t|
    t.integer  "feeded_to_id"
    t.string   "feeded_to_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
