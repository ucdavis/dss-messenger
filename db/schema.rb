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

ActiveRecord::Schema.define(version: 20150831220209) do

  create_table "audiences", force: :cascade do |t|
    t.integer  "message_id",   limit: 4
    t.integer  "recipient_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "broadcasts", force: :cascade do |t|
    t.integer  "message_id",         limit: 4
    t.integer  "messenger_event_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "classifications", force: :cascade do |t|
    t.string   "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "classifications", ["id"], name: "index_classifications_on_id", using: :btree

  create_table "damages", force: :cascade do |t|
    t.integer  "message_id",          limit: 4
    t.integer  "impacted_service_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0
    t.integer  "attempts",   limit: 4,     default: 0
    t.text     "handler",    limit: 65535
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "impacted_services", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impacted_services", ["id"], name: "index_impacted_services_on_id", using: :btree

  create_table "message_logs", force: :cascade do |t|
    t.integer  "message_id",      limit: 4
    t.datetime "start"
    t.datetime "finish"
    t.integer  "status",          limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "recipient_count", limit: 4
    t.integer  "viewed_count",    limit: 4, default: 0
    t.integer  "publisher_id",    limit: 4
  end

  add_index "message_logs", ["message_id"], name: "index_message_logs_on_message_id", using: :btree
  add_index "message_logs", ["publisher_id"], name: "index_message_logs_on_publisher_id", using: :btree

  create_table "message_receipts", force: :cascade do |t|
    t.integer  "message_log_id",  limit: 4
    t.string   "recipient_name",  limit: 255
    t.string   "recipient_email", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "viewed"
    t.string   "login_id",        limit: 255
    t.datetime "performed_at"
  end

  create_table "messages", force: :cascade do |t|
    t.string   "subject",           limit: 255
    t.text     "impact_statement",  limit: 65535
    t.datetime "window_start"
    t.datetime "window_end"
    t.text     "purpose",           limit: 65535
    t.text     "resolution",        limit: 65535
    t.text     "workaround",        limit: 65535
    t.text     "other_services",    limit: 65535
    t.string   "sender",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "classification_id", limit: 4
    t.integer  "modifier_id",       limit: 4
    t.boolean  "closed",                          default: false
  end

  add_index "messages", ["id"], name: "index_messages_on_id", using: :btree

  create_table "modifiers", force: :cascade do |t|
    t.string   "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "open_ended"
  end

  add_index "modifiers", ["id"], name: "index_modifiers_on_id", using: :btree

  create_table "publishers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "class_name", limit: 255
    t.boolean  "default"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipients", force: :cascade do |t|
    t.string   "uid",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",       limit: 255
  end

  add_index "recipients", ["id"], name: "index_recipients_on_id", using: :btree
  add_index "recipients", ["uid"], name: "index_recipients_on_uid", using: :btree

  create_table "settings", force: :cascade do |t|
    t.string   "item_name",  limit: 255
    t.text     "item_value", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["id"], name: "index_settings_on_id", using: :btree

end
