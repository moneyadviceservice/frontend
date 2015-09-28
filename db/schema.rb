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

ActiveRecord::Schema.define(version: 20150925110305) do

  create_table "advice_plans_plans", force: true do |t|
    t.string   "code",                             null: false
    t.boolean  "current",      default: false,     null: false
    t.datetime "started_at"
    t.datetime "completed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "owner_id"
    t.string   "owner_type"
    t.boolean  "crisis",       default: false
    t.string   "status",       default: "unknown", null: false
  end

  add_index "advice_plans_plans", ["code"], name: "index_advice_plans_plans_on_code", using: :btree
  add_index "advice_plans_plans", ["current"], name: "index_advice_plans_plans_on_current", using: :btree
  add_index "advice_plans_plans", ["owner_id", "owner_type"], name: "index_advice_plans_plans_on_owner_id_and_owner_type", using: :btree

  create_table "advice_plans_plans_tasks", id: false, force: true do |t|
    t.integer "plan_id", null: false
    t.integer "task_id", null: false
  end

  add_index "advice_plans_plans_tasks", ["plan_id"], name: "index_advice_plans_plans_tasks_on_plan_id", using: :btree
  add_index "advice_plans_plans_tasks", ["task_id"], name: "index_advice_plans_plans_tasks_on_task_id", using: :btree

  create_table "advice_plans_tasks", force: true do |t|
    t.string   "code",                             null: false
    t.datetime "started_at"
    t.datetime "completed_at"
    t.datetime "dismissed_at"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "state"
    t.datetime "deadline"
    t.string   "owner_id"
    t.string   "owner_type"
    t.string   "deadline_name"
    t.boolean  "email",             default: true
    t.string   "started_plan_slug"
    t.date     "due_date"
  end

  add_index "advice_plans_tasks", ["code"], name: "index_advice_plans_tasks_on_code", using: :btree
  add_index "advice_plans_tasks", ["deadline"], name: "index_advice_plans_tasks_on_deadline", using: :btree
  add_index "advice_plans_tasks", ["owner_id", "owner_type"], name: "index_advice_plans_tasks_on_owner_id_and_owner_type", using: :btree
  add_index "advice_plans_tasks", ["state"], name: "index_advice_plans_tasks_on_state", using: :btree

  create_table "agreements_agreements", force: true do |t|
    t.string   "name"
    t.string   "email_address"
    t.string   "organisation_name"
    t.string   "organisation_registered_number"
    t.string   "website"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "token"
    t.string   "type"
    t.string   "debt_evaluation_toolkit_area"
    t.string   "debt_evaluation_toolkit_membership"
    t.boolean  "debt_evaluation_toolkit_allow_contact"
  end

  create_table "budget_planner_budgets", force: true do |t|
    t.binary   "data",               null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "user_id"
    t.string   "commited_from"
    t.string   "last_commited_from"
  end

  add_index "budget_planner_budgets", ["user_id"], name: "index_budget_planner_budgets_on_user_id", using: :btree

  create_table "budget_planner_wip_budgets", force: true do |t|
    t.binary   "data",             null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "user_id"
    t.integer  "source_budget_id"
    t.string   "source_website"
    t.datetime "commited_at"
  end

  add_index "budget_planner_wip_budgets", ["user_id"], name: "index_budget_planner_wip_budgets_on_user_id", using: :btree

  create_table "car_cost_tool_car_adjustments", force: true do |t|
    t.integer "user_data_id"
    t.string  "cap_id"
    t.string  "vrm"
    t.integer "current_mileage"
    t.decimal "annual_insurance",  precision: 8, scale: 2
    t.decimal "purchase_price",    precision: 8, scale: 2
    t.decimal "depreciation",      precision: 8, scale: 2
    t.integer "registration_year"
  end

  create_table "car_cost_tool_fuel_prices", force: true do |t|
    t.string   "fuel_type"
    t.decimal  "price_in_pence", precision: 10, scale: 6
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "car_cost_tool_user_data", force: true do |t|
    t.string  "token"
    t.integer "annual_mileage"
    t.integer "intended_ownership_term"
    t.integer "registration_year"
    t.decimal "maintenance_cost",        precision: 10, scale: 0
  end

  add_index "car_cost_tool_user_data", ["token"], name: "index_car_cost_tool_user_data_on_token", unique: true, using: :btree

  create_table "car_cost_tool_ved_capacity_rates", force: true do |t|
    t.integer  "cc_lower_limit"
    t.integer  "cc_upper_limit"
    t.integer  "annual_price_in_pence"
    t.integer  "six_month_price_in_pence"
    t.string   "tax_year"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "car_cost_tool_ved_co2_bands", force: true do |t|
    t.string   "band"
    t.string   "fuel_type"
    t.integer  "co2_lower_limit"
    t.integer  "co2_upper_limit"
    t.integer  "annual_price_in_pence"
    t.integer  "six_month_price_in_pence"
    t.string   "tax_year"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "corporate_partners", force: true do |t|
    t.string   "name",            null: false
    t.string   "email",           null: false
    t.string   "tool_name"
    t.string   "tool_language"
    t.string   "tool_width_unit"
    t.integer  "tool_width",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cost_calculator_builder_calculators", force: true do |t|
    t.string   "name"
    t.string   "display_name"
    t.date     "target_date"
    t.integer  "duration_in_days"
    t.string   "duration_type"
    t.string   "duration_label"
    t.string   "summary_name"
    t.text     "summary_description"
    t.text     "summary_callout_note"
    t.text     "final_balance_text"
    t.text     "good_balance_summary"
    t.text     "bad_balance_summary"
    t.integer  "balance_threshold",                 default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.boolean  "invert_threshold_value",            default: false
    t.text     "good_balance_summary_after_amount"
    t.text     "bad_balance_summary_after_amount"
    t.string   "countdown_precision"
  end

  add_index "cost_calculator_builder_calculators", ["slug"], name: "index_cost_calculator_builder_calculators_on_slug", unique: true, using: :btree

  create_table "cost_calculator_builder_call_to_actions", force: true do |t|
    t.string   "name"
    t.text     "text"
    t.string   "url"
    t.integer  "calculator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "value",         default: "positive", null: false
    t.boolean  "nofollow",      default: true
  end

  add_index "cost_calculator_builder_call_to_actions", ["calculator_id"], name: "index_cost_calculator_builder_call_to_actions_on_calculator_id", using: :btree

  create_table "cost_calculator_builder_expense_pages", force: true do |t|
    t.string   "name"
    t.string   "page_type"
    t.text     "description"
    t.text     "callout_note"
    t.text     "total_note"
    t.boolean  "user_submitted_date"
    t.integer  "calculator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "index"
    t.boolean  "allow_user_duration"
  end

  add_index "cost_calculator_builder_expense_pages", ["calculator_id"], name: "index_cost_calculator_builder_expense_pages_on_calculator_id", using: :btree

  create_table "cost_calculator_builder_expenses", force: true do |t|
    t.string   "name"
    t.string   "expense_type"
    t.text     "help_text"
    t.text     "instructive_text"
    t.integer  "min_value",                                 default: 0
    t.integer  "max_value"
    t.integer  "default_value",                             default: 0
    t.string   "multiplier_text"
    t.decimal  "multiplier_value", precision: 10, scale: 0
    t.integer  "expense_page_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "custom_duration",                           default: 0, null: false
    t.boolean  "enable_more"
  end

  add_index "cost_calculator_builder_expenses", ["expense_page_id"], name: "index_cost_calculator_builder_expenses_on_expense_page_id", using: :btree

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

  create_table "debt_advice_locator_organisation_awards", force: true do |t|
    t.integer "organisation_standard_id"
    t.integer "organisation_id"
  end

  create_table "debt_advice_locator_organisation_standards", force: true do |t|
    t.string  "name"
    t.boolean "free", default: true
  end

  create_table "debt_advice_locator_organisations", force: true do |t|
    t.string   "name"
    t.text     "address_street_address"
    t.string   "address_locality"
    t.string   "address_region"
    t.string   "address_postcode"
    t.float    "lat",                                          limit: 24
    t.float    "lng",                                          limit: 24
    t.string   "email_address"
    t.string   "website_address"
    t.string   "minicom"
    t.text     "notes"
    t.boolean  "provides_face_to_face",                                   default: false, null: false
    t.boolean  "provides_telephone",                                      default: false, null: false
    t.boolean  "provides_web",                                            default: false, null: false
    t.datetime "created_at",                                                              null: false
    t.datetime "updated_at",                                                              null: false
    t.string   "telephone_en"
    t.string   "telephone_cy"
    t.boolean  "region_england",                                          default: false, null: false
    t.boolean  "region_northern_ireland",                                 default: false, null: false
    t.boolean  "region_scotland",                                         default: false, null: false
    t.boolean  "region_wales",                                            default: false, null: false
    t.string   "website_address_text"
    t.string   "notes_cy"
    t.integer  "debt_advice_locator_organisation_standard_id"
    t.boolean  "display_in_accredited_list",                              default: false
  end

  add_index "debt_advice_locator_organisations", ["lat", "lng"], name: "dal_organisations_lat_lng", using: :btree
  add_index "debt_advice_locator_organisations", ["provides_face_to_face"], name: "dal_organisations_provides_face_to_face", using: :btree
  add_index "debt_advice_locator_organisations", ["provides_telephone"], name: "dal_organisations_provides_telephone", using: :btree
  add_index "debt_advice_locator_organisations", ["provides_web"], name: "dal_organisations_provides_web", using: :btree

  create_table "debt_free_day_calculator_calculations", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "type"
    t.string   "uuid"
  end

  add_index "debt_free_day_calculator_calculations", ["type"], name: "dfdc_calculations_type", using: :btree
  add_index "debt_free_day_calculator_calculations", ["uuid"], name: "dfdc_calculations_uuid", using: :btree

  create_table "debt_free_day_calculator_debts", force: true do |t|
    t.string   "title",                                   default: ""
    t.decimal  "balance",        precision: 10, scale: 2
    t.decimal  "apr",            precision: 6,  scale: 2
    t.decimal  "repayment",      precision: 10, scale: 2
    t.decimal  "months",         precision: 10, scale: 2
    t.integer  "calculation_id"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.string   "type"
    t.decimal  "cost",           precision: 10, scale: 2
    t.decimal  "interest",       precision: 10, scale: 2
  end

  add_index "debt_free_day_calculator_debts", ["type"], name: "dfdc_debts_type", using: :btree

  create_table "debt_health_answer_resources", force: true do |t|
    t.integer  "answer_id"
    t.integer  "resource_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "debt_health_answer_resources", ["answer_id", "resource_id"], name: "index_on_answer_id_and_resource_id", using: :btree

  create_table "debt_health_answers", force: true do |t|
    t.string   "title"
    t.integer  "question_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "score",       default: 0
  end

  create_table "debt_health_categories", force: true do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "debt_health_questionnaires", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "debt_health_questions", force: true do |t|
    t.string   "title"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "row_order",   default: 0
    t.integer  "category_id"
    t.string   "heading"
  end

  create_table "debt_health_resources", force: true do |t|
    t.string  "url"
    t.string  "title"
    t.string  "resource_type"
    t.integer "score",         default: 0
    t.string  "external_id"
    t.integer "result_id"
  end

  create_table "debt_health_responses", force: true do |t|
    t.integer  "question_id"
    t.integer  "answer_id"
    t.integer  "questionnaire_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "debt_health_results", force: true do |t|
    t.text     "body"
    t.text     "intro"
    t.integer  "score_min"
    t.integer  "score_max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0
    t.integer  "attempts",   default: 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "divorce_and_separation_tool_states", force: true do |t|
    t.string   "unique_id"
    t.text     "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "divorce_and_separation_tool_states", ["unique_id"], name: "index_divorce_and_separation_tool_states_on_unique_id", using: :btree

  create_table "external_actions", force: true do |t|
    t.string   "text_en",    null: false
    t.string   "text_cy",    null: false
    t.string   "url"
    t.datetime "due_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "isa_alerts", force: true do |t|
    t.integer  "user_id",                                                  null: false
    t.string   "product_type",                                             null: false
    t.string   "provider_name",                                            null: false
    t.decimal  "interest_rate",   precision: 10, scale: 2,                 null: false
    t.date     "expiry_date",                                              null: false
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.string   "locale",                                   default: "en",  null: false
    t.boolean  "email_scheduled",                          default: false
  end

  create_table "page_views", force: true do |t|
    t.string   "name"
    t.integer  "count"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "locale",     limit: 2
  end

  add_index "page_views", ["name"], name: "index_page_views_on_name", unique: true, using: :btree

  create_table "partner_polling_audit_records", force: true do |t|
    t.integer  "poll_user_id"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "action"
    t.datetime "created_at"
  end

  add_index "partner_polling_audit_records", ["resource_type", "resource_id"], name: "index_partner_polling_audit_records_on_resource", using: :btree

  create_table "partner_polling_partners", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "color_1"
    t.string   "color_2"
    t.string   "color_3"
    t.string   "color_4"
    t.string   "call_to_action_color"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "partner_polling_partners", ["slug"], name: "index_partner_polling_partners_on_slug", unique: true, using: :btree

  create_table "partner_polling_poll_users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin",                  default: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "partner_polling_poll_users", ["email"], name: "index_partner_polling_poll_users_on_email", unique: true, using: :btree
  add_index "partner_polling_poll_users", ["reset_password_token"], name: "index_partner_polling_poll_users_on_reset_password_token", unique: true, using: :btree

  create_table "partner_polling_polls", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "question"
    t.string   "answer_1"
    t.string   "answer_2"
    t.string   "answer_3"
    t.string   "answer_4"
    t.boolean  "archived",   default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "partner_polling_polls", ["slug"], name: "index_partner_polling_polls_on_slug", unique: true, using: :btree

  create_table "partner_polling_redirections", force: true do |t|
    t.integer  "widget_id"
    t.integer  "vote_id"
    t.integer  "answer_number"
    t.string   "ip_address"
    t.datetime "created_at"
  end

  add_index "partner_polling_redirections", ["widget_id"], name: "index_partner_polling_redirections_on_widget_id", using: :btree

  create_table "partner_polling_votes", force: true do |t|
    t.integer  "widget_id"
    t.integer  "answer_number"
    t.string   "ip_address"
    t.datetime "created_at"
  end

  add_index "partner_polling_votes", ["widget_id"], name: "index_partner_polling_votes_on_widget_id", using: :btree

  create_table "partner_polling_widget_hosts", force: true do |t|
    t.integer  "widget_id"
    t.text     "url"
    t.string   "name"
    t.datetime "created_at"
  end

  add_index "partner_polling_widget_hosts", ["widget_id"], name: "index_partner_polling_widget_hosts_on_widget_id", using: :btree

  create_table "partner_polling_widgets", force: true do |t|
    t.integer  "poll_id"
    t.integer  "partner_id"
    t.text     "call_to_action_text_1"
    t.text     "call_to_action_url_1"
    t.string   "color_1"
    t.text     "call_to_action_text_2"
    t.text     "call_to_action_url_2"
    t.string   "color_2"
    t.text     "call_to_action_text_3"
    t.text     "call_to_action_url_3"
    t.string   "color_3"
    t.text     "call_to_action_text_4"
    t.text     "call_to_action_url_4"
    t.string   "color_4"
    t.text     "default_call_to_action_text"
    t.text     "default_call_to_action_url"
    t.string   "call_to_action_color"
    t.boolean  "logo",                        default: true
    t.boolean  "see_results",                 default: true
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.boolean  "same_window"
  end

  add_index "partner_polling_widgets", ["partner_id"], name: "index_partner_polling_widgets_on_partner_id", using: :btree
  add_index "partner_polling_widgets", ["poll_id"], name: "index_partner_polling_widgets_on_poll_id", using: :btree

  create_table "quiz_audit_records", force: true do |t|
    t.integer  "user_id"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "action"
    t.datetime "created_at"
  end

  add_index "quiz_audit_records", ["resource_type", "resource_id"], name: "index_quiz_audit_records_on_resource", using: :btree

  create_table "quiz_partners", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "background_color"
    t.string   "primary_color"
    t.string   "secondary_color"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "sidenav_header_color"
    t.string   "sidenav_header_text_color"
    t.string   "banner_text_color"
    t.string   "question_heading_color"
    t.string   "button_color"
    t.string   "button_text_color"
  end

  add_index "quiz_partners", ["slug"], name: "index_quiz_partners_on_slug", unique: true, using: :btree

  create_table "quiz_player_responses", force: true do |t|
    t.integer  "response"
    t.boolean  "correct"
    t.boolean  "demo"
    t.integer  "player_id"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "quiz_players", force: true do |t|
    t.integer  "widget_id"
    t.boolean  "demo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quiz_questions", force: true do |t|
    t.integer  "quiz_id"
    t.text     "question_en"
    t.text     "question_cy"
    t.string   "image_uid"
    t.string   "answer_1_en"
    t.string   "answer_2_en"
    t.string   "answer_3_en"
    t.string   "answer_4_en"
    t.string   "answer_1_cy"
    t.string   "answer_2_cy"
    t.string   "answer_3_cy"
    t.string   "answer_4_cy"
    t.integer  "correct_answer_number"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "image_url"
  end

  add_index "quiz_questions", ["quiz_id"], name: "index_quiz_questions_on_quiz_id", using: :btree

  create_table "quiz_quiz_users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin",                  default: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "quiz_quiz_users", ["email"], name: "index_quiz_quiz_users_on_email", unique: true, using: :btree
  add_index "quiz_quiz_users", ["reset_password_token"], name: "index_quiz_quiz_users_on_reset_password_token", unique: true, using: :btree

  create_table "quiz_quizzes", force: true do |t|
    t.string   "name_en"
    t.string   "name_cy"
    t.string   "slogan_en"
    t.string   "slogan_cy"
    t.string   "score_summary_low_en"
    t.string   "score_summary_mid_en"
    t.string   "score_summary_high_en"
    t.string   "score_summary_low_cy"
    t.string   "score_summary_mid_cy"
    t.string   "score_summary_high_cy"
    t.boolean  "archived",                    default: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.text     "score_summary_low_blurb_en"
    t.text     "score_summary_mid_blurb_en"
    t.text     "score_summary_high_blurb_en"
    t.text     "score_summary_low_blurb_cy"
    t.text     "score_summary_mid_blurb_cy"
    t.text     "score_summary_high_blurb_cy"
  end

  create_table "quiz_widget_hosts", force: true do |t|
    t.integer  "widget_id"
    t.text     "url"
    t.string   "name"
    t.datetime "created_at"
  end

  add_index "quiz_widget_hosts", ["widget_id"], name: "index_quiz_widget_hosts_on_widget_id", using: :btree

  create_table "quiz_widget_snippets", force: true do |t|
    t.integer "widget_id"
    t.integer "question_id"
    t.string  "slug"
    t.text    "value"
  end

  create_table "quiz_widgets", force: true do |t|
    t.integer  "quiz_id"
    t.integer  "partner_id"
    t.text     "feed_url_en"
    t.text     "feed_url_cy"
    t.text     "front_page_text_en"
    t.text     "front_page_text_cy"
    t.string   "image_uid"
    t.string   "background_color"
    t.string   "primary_color"
    t.string   "secondary_color"
    t.boolean  "no_follow"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "image_url_1"
    t.string   "image_url_2"
    t.string   "image_url_3"
    t.string   "sidenav_header_color"
    t.string   "sidenav_header_text_color"
    t.string   "banner_text_color"
    t.string   "question_heading_color"
    t.string   "button_color"
    t.string   "button_text_color"
    t.boolean  "show_mas_logo",             default: false
  end

  add_index "quiz_widgets", ["partner_id"], name: "index_quiz_widgets_on_partner_id", using: :btree
  add_index "quiz_widgets", ["quiz_id"], name: "index_quiz_widgets_on_quiz_id", using: :btree

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "student_money_tips_audit_records", force: true do |t|
    t.integer  "user_id"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "action"
    t.datetime "created_at"
  end

  add_index "student_money_tips_audit_records", ["resource_type", "resource_id"], name: "index_student_money_tips_audit_records_on_resource", using: :btree

  create_table "student_money_tips_scenarios", force: true do |t|
    t.string   "name_en"
    t.string   "name_cy"
    t.integer  "position",   default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "student_money_tips_scenarios_tools", id: false, force: true do |t|
    t.integer "scenario_id"
    t.integer "tool_id"
  end

  add_index "student_money_tips_scenarios_tools", ["scenario_id"], name: "index_student_money_tips_scenarios_tools_on_scenario_id", using: :btree
  add_index "student_money_tips_scenarios_tools", ["tool_id"], name: "index_student_money_tips_scenarios_tools_on_tool_id", using: :btree

  create_table "student_money_tips_snippets", force: true do |t|
    t.string  "slug"
    t.string  "name"
    t.string  "field_type"
    t.text    "value"
    t.integer "position"
  end

  create_table "student_money_tips_tips", force: true do |t|
    t.integer  "scenario_id"
    t.text     "text_en"
    t.text     "text_cy"
    t.integer  "position",    default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "student_money_tips_tips", ["scenario_id"], name: "index_student_money_tips_tips_on_scenario_id", using: :btree

  create_table "student_money_tips_tips_users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin",                  default: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "student_money_tips_tips_users", ["email"], name: "index_student_money_tips_tips_users_on_email", unique: true, using: :btree
  add_index "student_money_tips_tips_users", ["reset_password_token"], name: "index_student_money_tips_tips_users_on_reset_password_token", unique: true, using: :btree

  create_table "student_money_tips_tools", force: true do |t|
    t.string   "name"
    t.text     "title_en"
    t.text     "title_cy"
    t.string   "link_text_en"
    t.string   "link_text_cy"
    t.text     "url_en"
    t.text     "url_cy"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "student_money_tips_widget_hosts", force: true do |t|
    t.text     "url"
    t.string   "name"
    t.datetime "created_at"
  end

  create_table "survey_responses", force: true do |t|
    t.string   "survey_id"
    t.integer  "user_id"
    t.string   "response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "ip_address"
    t.string   "user_agent"
  end

  add_index "survey_responses", ["user_id"], name: "survey_responses_user_id_fk", using: :btree

  create_table "topics", force: true do |t|
    t.string   "name_en"
    t.string   "name_cy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topics_users", id: false, force: true do |t|
    t.integer  "topic_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topics_users", ["topic_id"], name: "topics_users_topic_id_fk", using: :btree
  add_index "topics_users", ["user_id"], name: "topics_users_user_id_fk", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                                     default: "",    null: false
    t.string   "encrypted_password",                        default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",                             default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.boolean  "accept_terms_conditions"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_salt"
    t.string   "post_code"
    t.string   "age_range"
    t.string   "gender"
    t.boolean  "newsletter_subscription",                   default: false
    t.string   "customer_id"
    t.text     "health_check_result"
    t.boolean  "active",                                    default: true
    t.date     "date_of_birth"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "csr_id"
    t.string   "invitation_token",               limit: 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "failed_attempts",                           default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "temporary_authentication_token"
    t.string   "goal_statement"
    t.string   "goal_deadline"
    t.string   "contact_number"
    t.boolean  "opt_in_for_research",                default: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["temporary_authentication_token"], name: "index_users_on_temporary_authentication_token", unique: true, using: :btree

end
