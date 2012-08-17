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

ActiveRecord::Schema.define(:version => 20120814124454) do

  create_table "accommodations", :force => true do |t|
    t.string   "locale",                            :null => false
    t.integer  "posted_by_id"
    t.string   "posted_by_type"
    t.string   "category",                          :null => false
    t.string   "subject",                           :null => false
    t.integer  "valid_days",     :default => 0
    t.datetime "valid_until",                       :null => false
    t.integer  "views",          :default => 0
    t.integer  "likes",          :default => 0
    t.integer  "dislikes",       :default => 0
    t.integer  "rank",           :default => 0
    t.integer  "abuse",          :default => 0
    t.boolean  "is_deleted",     :default => false
    t.integer  "z_index",        :default => 0
    t.integer  "write_at"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.float    "price"
    t.string   "room_type"
  end

  create_table "admins", :force => true do |t|
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
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "attachments", :force => true do |t|
    t.boolean  "is_deleted",          :default => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "medium_size"
    t.string   "thumb_size"
    t.integer  "attached_by_id"
    t.string   "attached_by_type"
    t.integer  "attached_id"
    t.string   "attached_type"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "write_at"
  end

  create_table "banner_images", :force => true do |t|
    t.integer  "banner_id"
    t.integer  "client_image_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "banners", :force => true do |t|
    t.integer  "page_id"
    t.integer  "section_id"
    t.integer  "position_id"
    t.string   "display_name"
    t.integer  "div_width"
    t.integer  "div_height"
    t.integer  "img_width"
    t.integer  "img_height"
    t.string   "style"
    t.string   "effect"
    t.integer  "effect_speed"
    t.boolean  "is_random",    :default => false
    t.boolean  "is_disabled",  :default => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "business_categories", :force => true do |t|
    t.string   "name"
    t.string   "seach_keyword"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "business_clients", :force => true do |t|
    t.string   "business_name",        :null => false
    t.string   "business_abn"
    t.string   "business_address"
    t.string   "business_url"
    t.string   "business_phone"
    t.string   "business_fax"
    t.string   "business_email"
    t.string   "contact_name"
    t.string   "search_keyword"
    t.integer  "business_category_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "business_profile_images", :force => true do |t|
    t.boolean  "is_deleted",          :default => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "medium_size"
    t.string   "thumb_size"
    t.integer  "attached_by_id"
    t.string   "attached_by_type"
    t.integer  "attached_id"
    t.string   "attached_type"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.boolean  "is_main",             :default => false
  end

  create_table "business_profiles", :force => true do |t|
    t.string   "head"
    t.text     "body",                 :limit => 16777215
    t.integer  "business_client_id"
    t.string   "business_client_type"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "businesses", :force => true do |t|
    t.string   "locale",                            :null => false
    t.integer  "posted_by_id"
    t.string   "posted_by_type"
    t.string   "category",                          :null => false
    t.string   "subject",                           :null => false
    t.integer  "valid_days",     :default => 0
    t.datetime "valid_until",                       :null => false
    t.integer  "views",          :default => 0
    t.integer  "likes",          :default => 0
    t.integer  "dislikes",       :default => 0
    t.integer  "rank",           :default => 0
    t.integer  "abuse",          :default => 0
    t.boolean  "is_deleted",     :default => false
    t.integer  "z_index",        :default => 0
    t.integer  "write_at"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.float    "price"
    t.boolean  "is_sold",        :default => false
  end

  create_table "buy_and_sells", :force => true do |t|
    t.string   "locale",                            :null => false
    t.integer  "posted_by_id"
    t.string   "posted_by_type"
    t.string   "category",                          :null => false
    t.string   "subject",                           :null => false
    t.integer  "valid_days",     :default => 0
    t.datetime "valid_until",                       :null => false
    t.integer  "views",          :default => 0
    t.integer  "likes",          :default => 0
    t.integer  "dislikes",       :default => 0
    t.integer  "rank",           :default => 0
    t.integer  "abuse",          :default => 0
    t.boolean  "is_deleted",     :default => false
    t.integer  "z_index",        :default => 0
    t.integer  "write_at"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.float    "price"
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "client_images", :force => true do |t|
    t.boolean  "is_deleted",          :default => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "medium_size"
    t.string   "thumb_size"
    t.integer  "attached_by_id"
    t.string   "attached_by_type"
    t.integer  "attached_id"
    t.string   "attached_type"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "clicked",             :default => 0
    t.datetime "last_clicked"
    t.string   "original_size"
    t.string   "caption"
    t.string   "source_url"
    t.string   "link_to_url"
  end

  create_table "comments", :force => true do |t|
    t.boolean  "is_deleted",        :default => false
    t.string   "locale"
    t.text     "body"
    t.integer  "abuse",             :default => 0
    t.integer  "likes",             :default => 0
    t.integer  "dislikes",          :default => 0
    t.integer  "commented_id"
    t.string   "commented_type"
    t.integer  "commented_by_id"
    t.string   "commented_by_type"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  create_table "contents", :force => true do |t|
    t.text     "body",           :limit => 16777215
    t.integer  "contented_id"
    t.string   "contented_type"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "estates", :force => true do |t|
    t.string   "locale",                            :null => false
    t.integer  "posted_by_id"
    t.string   "posted_by_type"
    t.string   "category",                          :null => false
    t.string   "subject",                           :null => false
    t.integer  "valid_days",     :default => 0
    t.datetime "valid_until",                       :null => false
    t.integer  "views",          :default => 0
    t.integer  "likes",          :default => 0
    t.integer  "dislikes",       :default => 0
    t.integer  "rank",           :default => 0
    t.integer  "abuse",          :default => 0
    t.boolean  "is_deleted",     :default => false
    t.integer  "z_index",        :default => 0
    t.integer  "write_at"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.float    "price"
    t.string   "address"
    t.boolean  "is_sold",        :default => false
    t.integer  "bed",            :default => 0
    t.integer  "bath",           :default => 0
    t.integer  "garage",         :default => 0
  end

  create_table "homes", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "images", :force => true do |t|
    t.boolean  "is_deleted",          :default => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "medium_size"
    t.string   "thumb_size"
    t.integer  "attached_by_id"
    t.string   "attached_by_type"
    t.integer  "attached_id"
    t.string   "attached_type"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "write_at"
    t.string   "something"
  end

  create_table "immigrations", :force => true do |t|
    t.string   "locale",                            :null => false
    t.integer  "posted_by_id"
    t.string   "posted_by_type"
    t.string   "category",                          :null => false
    t.string   "subject",                           :null => false
    t.integer  "valid_days",     :default => 0
    t.datetime "valid_until",                       :null => false
    t.integer  "views",          :default => 0
    t.integer  "likes",          :default => 0
    t.integer  "dislikes",       :default => 0
    t.integer  "rank",           :default => 0
    t.integer  "abuse",          :default => 0
    t.boolean  "is_deleted",     :default => false
    t.integer  "z_index",        :default => 0
    t.integer  "write_at"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "jobs", :force => true do |t|
    t.string   "locale",                            :null => false
    t.integer  "posted_by_id"
    t.string   "posted_by_type"
    t.string   "category",                          :null => false
    t.string   "subject",                           :null => false
    t.integer  "valid_days",     :default => 0
    t.datetime "valid_until",                       :null => false
    t.integer  "views",          :default => 0
    t.integer  "likes",          :default => 0
    t.integer  "dislikes",       :default => 0
    t.integer  "rank",           :default => 0
    t.integer  "abuse",          :default => 0
    t.boolean  "is_deleted",     :default => false
    t.integer  "z_index",        :default => 0
    t.integer  "write_at"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "laws", :force => true do |t|
    t.string   "locale",                            :null => false
    t.integer  "posted_by_id"
    t.string   "posted_by_type"
    t.string   "category",                          :null => false
    t.string   "subject",                           :null => false
    t.integer  "valid_days",     :default => 0
    t.datetime "valid_until",                       :null => false
    t.integer  "views",          :default => 0
    t.integer  "likes",          :default => 0
    t.integer  "dislikes",       :default => 0
    t.integer  "rank",           :default => 0
    t.integer  "abuse",          :default => 0
    t.boolean  "is_deleted",     :default => false
    t.integer  "z_index",        :default => 0
    t.integer  "write_at"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "member_managements", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "motor_vehicles", :force => true do |t|
    t.string   "locale",                            :null => false
    t.integer  "posted_by_id"
    t.string   "posted_by_type"
    t.string   "category",                          :null => false
    t.string   "subject",                           :null => false
    t.integer  "valid_days",     :default => 0
    t.datetime "valid_until",                       :null => false
    t.integer  "views",          :default => 0
    t.integer  "likes",          :default => 0
    t.integer  "dislikes",       :default => 0
    t.integer  "rank",           :default => 0
    t.integer  "abuse",          :default => 0
    t.boolean  "is_deleted",     :default => false
    t.integer  "z_index",        :default => 0
    t.integer  "write_at"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.float    "price"
    t.boolean  "is_sold",        :default => false
  end

  create_table "mypages", :force => true do |t|
    t.integer  "mypagable_id"
    t.string   "mypagable_type"
    t.boolean  "is_public",      :default => false
    t.string   "public_url"
    t.integer  "blocked",        :default => 0
    t.integer  "num_of_post",    :default => 0
    t.boolean  "is_blacklist",   :default => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "post_searches", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "role_name"
    t.integer  "role_value"
    t.integer  "rolable_id"
    t.string   "rolable_type"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "studies", :force => true do |t|
    t.string   "locale",                            :null => false
    t.integer  "posted_by_id"
    t.string   "posted_by_type"
    t.string   "category",                          :null => false
    t.string   "subject",                           :null => false
    t.integer  "valid_days",     :default => 0
    t.datetime "valid_until",                       :null => false
    t.integer  "views",          :default => 0
    t.integer  "likes",          :default => 0
    t.integer  "dislikes",       :default => 0
    t.integer  "rank",           :default => 0
    t.integer  "abuse",          :default => 0
    t.boolean  "is_deleted",     :default => false
    t.integer  "z_index",        :default => 0
    t.integer  "write_at"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "system_settings", :force => true do |t|
    t.integer  "post_expiry_length"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "taxes", :force => true do |t|
    t.string   "locale",                            :null => false
    t.integer  "posted_by_id"
    t.string   "posted_by_type"
    t.string   "category",                          :null => false
    t.string   "subject",                           :null => false
    t.integer  "valid_days",     :default => 0
    t.datetime "valid_until",                       :null => false
    t.integer  "views",          :default => 0
    t.integer  "likes",          :default => 0
    t.integer  "dislikes",       :default => 0
    t.integer  "rank",           :default => 0
    t.integer  "abuse",          :default => 0
    t.boolean  "is_deleted",     :default => false
    t.integer  "z_index",        :default => 0
    t.integer  "write_at"
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
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.string   "first_name",             :default => "",    :null => false
    t.string   "last_name",              :default => "",    :null => false
    t.boolean  "is_special",             :default => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

  create_table "well_beings", :force => true do |t|
    t.string   "locale",                            :null => false
    t.integer  "posted_by_id"
    t.string   "posted_by_type"
    t.string   "category",                          :null => false
    t.string   "subject",                           :null => false
    t.integer  "valid_days",     :default => 0
    t.datetime "valid_until",                       :null => false
    t.integer  "views",          :default => 0
    t.integer  "likes",          :default => 0
    t.integer  "dislikes",       :default => 0
    t.integer  "rank",           :default => 0
    t.integer  "abuse",          :default => 0
    t.boolean  "is_deleted",     :default => false
    t.integer  "z_index",        :default => 0
    t.integer  "write_at"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

end
