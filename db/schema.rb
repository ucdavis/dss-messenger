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

ActiveRecord::Schema.define(:version => 20131007195112) do

  create_table "audiences", :force => true do |t|
    t.integer  "message_id"
    t.integer  "recipient_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "broadcasts", :force => true do |t|
    t.integer  "message_id"
    t.integer  "messenger_event_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "classifications", :force => true do |t|
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "classifications", ["id"], :name => "index_classifications_on_id"

  create_table "damages", :force => true do |t|
    t.integer  "message_id"
    t.integer  "impacted_service_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "impacted_services", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "impacted_services", ["id"], :name => "index_impacted_services_on_id"

  create_table "message_log_entries", :force => true do |t|
    t.integer  "message_log_id"
    t.string   "recipient_name"
    t.string   "recipient_email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "message_logs", :force => true do |t|
    t.integer  "message_id"
    t.datetime "send_start"
    t.datetime "send_finish"
    t.integer  "send_status"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "recipient_count"
  end

  add_index "message_logs", ["message_id"], :name => "index_message_logs_on_message_id"

  create_table "messages", :force => true do |t|
    t.string   "subject"
    t.text     "impact_statement"
    t.datetime "window_start"
    t.datetime "window_end"
    t.text     "purpose"
    t.text     "resolution"
    t.text     "workaround"
    t.text     "other_services"
    t.string   "sender_uid"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "classification_id"
    t.integer  "modifier_id"
    t.boolean  "closed"
  end

  add_index "messages", ["id"], :name => "index_messages_on_id"

  create_table "modifiers", :force => true do |t|
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.boolean  "open_ended"
  end

  add_index "modifiers", ["id"], :name => "index_modifiers_on_id"

  create_table "recipients", :force => true do |t|
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
  end

  add_index "recipients", ["id"], :name => "index_recipients_on_id"
  add_index "recipients", ["uid"], :name => "index_recipients_on_uid"

  create_table "settings", :force => true do |t|
    t.string   "item_name"
    t.text     "item_value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "settings", ["id"], :name => "index_settings_on_id"

end
