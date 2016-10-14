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

ActiveRecord::Schema.define(version: 20160913162636) do

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

  create_table "dashboards_users", id: false, force: :cascade do |t|
    t.integer "dashboard_id"
    t.integer "user_id"
    t.index ["dashboard_id", "user_id"], name: "index_dashboards_users_on_dashboard_id_and_user_id", using: :btree
    t.index ["dashboard_id"], name: "index_dashboards_users_on_dashboard_id", using: :btree
    t.index ["user_id", "dashboard_id"], name: "index_dashboards_users_on_user_id_and_dashboard_id", using: :btree
    t.index ["user_id"], name: "index_dashboards_users_on_user_id", using: :btree
  end

  create_table "data_sources", force: :cascade do |t|
    t.string   "name"
    t.string   "database_type"
    t.string   "host"
    t.integer  "port"
    t.string   "user"
    t.string   "password"
    t.string   "database_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "queries", force: :cascade do |t|
    t.string   "name"
    t.text     "body"
    t.string   "interpreter"
    t.integer  "data_source_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "context",          default: ""
    t.string   "auth_token"
    t.integer  "width"
    t.integer  "height"
    t.boolean  "async",            default: false
    t.datetime "async_updated_at"
  end

  create_table "queries_users", id: false, force: :cascade do |t|
    t.integer "query_id"
    t.integer "user_id"
    t.index ["query_id", "user_id"], name: "index_queries_users_on_query_id_and_user_id", using: :btree
    t.index ["user_id", "query_id"], name: "index_queries_users_on_user_id_and_query_id", using: :btree
  end

  create_table "query_variables", force: :cascade do |t|
    t.integer  "queries_id"
    t.integer  "variables_id"
    t.string   "default_value"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["queries_id"], name: "index_query_variables_on_queries_id", using: :btree
    t.index ["variables_id"], name: "index_query_variables_on_variables_id", using: :btree
  end

  create_table "rails_admin_histories", force: :cascade do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.bigint   "year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["item", "table", "month", "year"], name: "index_rails_admin_histories", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin",               default: false
    t.string   "uid"
    t.string   "provider"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "image"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "variables", force: :cascade do |t|
    t.string   "name"
    t.string   "format"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "version_associations", force: :cascade do |t|
    t.integer "version_id"
    t.string  "foreign_key_name", null: false
    t.integer "foreign_key_id"
    t.index ["foreign_key_name", "foreign_key_id"], name: "index_version_associations_on_foreign_key", using: :btree
    t.index ["version_id"], name: "index_version_associations_on_version_id", using: :btree
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.integer  "transaction_id"
    t.text     "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
    t.index ["transaction_id"], name: "index_versions_on_transaction_id", using: :btree
  end

  add_foreign_key "query_variables", "queries", column: "queries_id"
  add_foreign_key "query_variables", "variables", column: "variables_id"
end
