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

ActiveRecord::Schema.define(version: 20130807092501) do

  create_table "budget_planner_budgets", force: true do |t|
    t.binary   "data",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "commited_from"
    t.string   "last_commited_from"
  end

  add_index "budget_planner_budgets", ["user_id"], name: "index_budget_planner_budgets_on_user_id", using: :btree

  create_table "budget_planner_legacy_budgets", force: true do |t|
    t.binary   "data",        null: false
    t.string   "legacy_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "accessed_at"
  end

  add_index "budget_planner_legacy_budgets", ["legacy_id"], name: "index_budget_planner_legacy_budgets_on_legacy_id", unique: true, using: :btree

  create_table "budget_planner_wip_budgets", force: true do |t|
    t.binary   "data",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "source_budget_id"
    t.string   "source_website"
    t.datetime "commited_at"
  end

  add_index "budget_planner_wip_budgets", ["user_id"], name: "index_budget_planner_wip_budgets_on_user_id", using: :btree

  create_table "csr_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "csr_id",                              null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "csr_users", ["email"], name: "index_csr_users_on_email", unique: true, using: :btree
  add_index "csr_users", ["reset_password_token"], name: "index_csr_users_on_reset_password_token", unique: true, using: :btree

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                              default: "",    null: false
    t.string   "encrypted_password",                 default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.boolean  "accept_terms_conditions"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_salt"
    t.string   "post_code"
    t.string   "age_range"
    t.string   "gender"
    t.boolean  "newsletter_subscription",            default: false
    t.string   "customer_id"
    t.text     "health_check_result"
    t.boolean  "active",                             default: true
    t.date     "date_of_birth"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "csr_id"
    t.string   "invitation_token",        limit: 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "failed_attempts",                    default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
