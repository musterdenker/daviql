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

ActiveRecord::Schema.define(version: 20160312171428) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dashboard_elements", force: :cascade do |t|
    t.integer "dashboard_id"
    t.integer "query_id"
    t.integer "position"
    t.integer "width"
    t.integer "height"
    t.index ["dashboard_id"], name: "index_dashboard_elements_on_dashboard_id", using: :btree
    t.index ["query_id"], name: "index_dashboard_elements_on_query_id", using: :btree
  end

  create_table "dashboards", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
  end

  create_table "data_sources", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "database_type", limit: 255
    t.string   "host",          limit: 255
    t.integer  "port"
    t.string   "user",          limit: 255
    t.string   "password",      limit: 255
    t.string   "database_name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "queries", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.text     "body"
    t.string   "interpreter",      limit: 255
    t.integer  "data_source_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "context",          limit: 255, default: ""
    t.string   "auth_token"
    t.integer  "width"
    t.integer  "height"
    t.boolean  "async",                        default: false
    t.datetime "async_updated_at"
  end

  create_table "queries_users", id: false, force: :cascade do |t|
    t.integer "query_id"
    t.integer "user_id"
    t.index ["query_id", "user_id"], name: "index_queries_users_on_query_id_and_user_id", using: :btree
    t.index ["user_id", "query_id"], name: "index_queries_users_on_user_id_and_query_id", using: :btree
  end

  create_table "rails_admin_histories", force: :cascade do |t|
    t.text     "message"
    t.string   "username",   limit: 255
    t.integer  "item"
    t.string   "table",      limit: 255
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["item", "table", "month", "year"], name: "index_rails_admin_histories", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin",                           default: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
