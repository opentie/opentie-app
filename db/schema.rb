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

ActiveRecord::Schema.define(version: 20150506130401) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"
  enable_extension "hstore"

  create_table "accounts", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name",               default: "",    null: false
    t.string   "email",              default: "",    null: false
    t.string   "password_digest",    default: "",    null: false
    t.json     "payload"
    t.string   "confirmation_token"
    t.boolean  "confirmed_email",    default: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "delegates", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "project_id"
    t.uuid     "account_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "priority",   default: 0, null: false
  end

  add_index "delegates", ["project_id", "account_id"], name: "index_delegates_on_project_id_and_account_id", unique: true, using: :btree

  create_table "divisions", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name"
    t.json     "payload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "global_settings", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name"
    t.json     "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invitations", force: :cascade do |t|
    t.uuid     "account_id"
    t.uuid     "project_id"
    t.string   "invited_email"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "project_comments", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "project_id"
    t.uuid     "role_id"
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "project_histories", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "project_id"
    t.string   "field"
    t.text     "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "project_histories", ["created_at"], name: "index_project_histories_on_created_at", using: :btree

  create_table "projects", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name"
    t.json     "payload"
    t.integer  "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "frozen_at"
  end

  add_index "projects", ["frozen_at"], name: "index_projects_on_frozen_at", using: :btree

  create_table "recovery_tokens", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "token",                             null: false
    t.uuid     "account_id",                        null: false
    t.boolean  "resetted_password", default: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "recovery_tokens", ["token"], name: "index_recovery_tokens_on_token", unique: true, using: :btree

  create_table "request_schemata", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "division_id"
    t.json     "payload"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.datetime "deadline_at"
    t.string   "name",        default: "", null: false
  end

  add_index "request_schemata", ["division_id"], name: "index_request_schemata_on_division_id", using: :btree

  create_table "requests", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "request_schema_id"
    t.uuid     "delegate_id"
    t.json     "payload"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "status",            default: 0, null: false
    t.datetime "soft_destroyed_at"
  end

  add_index "requests", ["delegate_id"], name: "index_requests_on_delegate_id", using: :btree
  add_index "requests", ["request_schema_id"], name: "index_requests_on_request_schema_id", using: :btree
  add_index "requests", ["soft_destroyed_at"], name: "index_requests_on_soft_destroyed_at", using: :btree

  create_table "roles", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "division_id"
    t.uuid     "account_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "roles", ["division_id", "account_id"], name: "index_roles_on_division_id_and_account_id", unique: true, using: :btree

end
