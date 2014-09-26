#
# This migration defines the basic set of tables needed to run the frontend and
# is a subset of those already introduced by the old public_website.
#
# To prevent collisions when these migrations are run against an existing
# database initialised from the public_website, the timestamp has been chosen
# to match that of the last migration from public_website already applied to
# the live database, which at the time this was created was:
#
#   20140515170453_make_users_lockable.rb
#

class CreateInitialTables < ActiveRecord::Migration
  def change
    create_table "csr_users" do |t|
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


    create_table "sessions" do |t|
      t.string   "session_id", null: false
      t.text     "data"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
    add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree


    create_table "users" do |t|
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
end
