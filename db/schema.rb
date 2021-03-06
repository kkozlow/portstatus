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

ActiveRecord::Schema.define(:version => 20130718085712) do

  create_table "devices", :force => true do |t|
    t.string   "name"
    t.string   "ip",               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "community"
    t.boolean  "is_biznes"
    t.boolean  "is_mpls"
    t.boolean  "is_iptvtransport"
    t.boolean  "is_dell"
    t.integer  "he_id"
  end

  create_table "devices_users", :id => false, :force => true do |t|
    t.integer "device_id"
    t.integer "user_id"
  end

  add_index "devices_users", ["device_id", "user_id"], :name => "index_devices_users_on_device_id_and_user_id"
  add_index "devices_users", ["user_id"], :name => "index_devices_users_on_user_id"

  create_table "hes", :force => true do |t|
    t.text     "address"
    t.boolean  "blocked"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_sessions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
