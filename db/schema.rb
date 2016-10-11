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

ActiveRecord::Schema.define(version: 20161006144737) do

  create_table "action_plans_expense_items", force: :cascade do |t|
    t.string  "kind",       limit: 256,             null: false
    t.integer "value",      limit: 4,   default: 0, null: false
    t.integer "frequency",  limit: 4,               null: false
    t.integer "expense_id", limit: 4,               null: false
  end

  create_table "action_plans_expenses", force: :cascade do |t|
    t.string  "category", limit: 256,             null: false
    t.integer "total",    limit: 4,   default: 0, null: false
    t.integer "plan_id",  limit: 4,               null: false
  end

  create_table "action_plans_redundancy_plans", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "current_task_id", limit: 4
  end

  create_table "action_plans_redundancy_stories", force: :cascade do |t|
    t.integer  "plan_id",                 limit: 4,   null: false
    t.date     "redundant_at"
    t.date     "started_at"
    t.date     "date_of_birth"
    t.integer  "salary",                  limit: 4
    t.string   "salary_period",           limit: 255
    t.boolean  "know_redundancy_package"
    t.string   "company_status",          limit: 255
    t.string   "redundant_employees",     limit: 255
    t.string   "state",                   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "package_amount",          limit: 4
    t.integer  "package_salary_units",    limit: 4
    t.string   "package_salary_period",   limit: 255
    t.integer  "package_duration_units",  limit: 4
    t.string   "package_duration_period", limit: 255
    t.boolean  "northern_ireland"
  end

  create_table "action_plans_redundancy_tasks", force: :cascade do |t|
    t.string   "code",       limit: 256,                 null: false
    t.boolean  "completed",              default: false, null: false
    t.integer  "plan_id",    limit: 4,                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "advice_plans_plans", force: :cascade do |t|
    t.string   "code",         limit: 255,                     null: false
    t.boolean  "current",                  default: false,     null: false
    t.datetime "started_at"
    t.datetime "completed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "owner_id",     limit: 255
    t.string   "owner_type",   limit: 255
    t.boolean  "crisis",                   default: false
    t.string   "status",       limit: 255, default: "unknown", null: false
  end

  add_index "advice_plans_plans", ["code"], name: "index_advice_plans_plans_on_code", using: :btree
  add_index "advice_plans_plans", ["current"], name: "index_advice_plans_plans_on_current", using: :btree
  add_index "advice_plans_plans", ["owner_id", "owner_type"], name: "index_advice_plans_plans_on_owner_id_and_owner_type", using: :btree

  create_table "advice_plans_plans_tasks", id: false, force: :cascade do |t|
    t.integer "plan_id", limit: 4, null: false
    t.integer "task_id", limit: 4, null: false
  end

  add_index "advice_plans_plans_tasks", ["plan_id"], name: "index_advice_plans_plans_tasks_on_plan_id", using: :btree
  add_index "advice_plans_plans_tasks", ["task_id"], name: "index_advice_plans_plans_tasks_on_task_id", using: :btree

  create_table "advice_plans_tasks", force: :cascade do |t|
    t.string   "code",              limit: 255,                null: false
    t.datetime "started_at"
    t.datetime "completed_at"
    t.datetime "dismissed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",             limit: 255
    t.datetime "deadline"
    t.string   "owner_id",          limit: 255
    t.string   "owner_type",        limit: 255
    t.string   "deadline_name",     limit: 255
    t.boolean  "email",                         default: true
    t.string   "started_plan_slug", limit: 255
  end

  add_index "advice_plans_tasks", ["code"], name: "index_advice_plans_tasks_on_code", using: :btree
  add_index "advice_plans_tasks", ["deadline"], name: "index_advice_plans_tasks_on_deadline", using: :btree
  add_index "advice_plans_tasks", ["owner_id", "owner_type"], name: "index_advice_plans_tasks_on_owner_id_and_owner_type", using: :btree
  add_index "advice_plans_tasks", ["state"], name: "index_advice_plans_tasks_on_state", using: :btree

  create_table "agreements_agreements", force: :cascade do |t|
    t.string   "name",                                  limit: 255
    t.string   "email_address",                         limit: 255
    t.string   "organisation_name",                     limit: 255
    t.string   "organisation_registered_number",        limit: 255
    t.string   "website",                               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token",                                 limit: 255
    t.string   "type",                                  limit: 255
    t.string   "debt_evaluation_toolkit_area",          limit: 255
    t.string   "debt_evaluation_toolkit_membership",    limit: 255
    t.boolean  "debt_evaluation_toolkit_allow_contact"
  end

  create_table "budget_planner_budgets", force: :cascade do |t|
    t.binary   "data",               limit: 65535, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",            limit: 4
    t.string   "commited_from",      limit: 255
    t.string   "last_commited_from", limit: 255
  end

  add_index "budget_planner_budgets", ["user_id"], name: "index_budget_planner_budgets_on_user_id", using: :btree

  create_table "budget_planner_spreadsheets", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,     null: false
    t.binary   "data",       limit: 65535, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "budget_planner_wip_budgets", force: :cascade do |t|
    t.binary   "data",             limit: 65535, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",          limit: 4
    t.integer  "source_budget_id", limit: 4
    t.string   "source_website",   limit: 255
    t.datetime "commited_at"
  end

  add_index "budget_planner_wip_budgets", ["user_id"], name: "index_budget_planner_wip_budgets_on_user_id", using: :btree

  create_table "car_cost_tool_car_adjustments", force: :cascade do |t|
    t.integer "user_data_id",      limit: 4
    t.string  "cap_id",            limit: 255
    t.string  "vrm",               limit: 255
    t.integer "current_mileage",   limit: 4
    t.decimal "annual_insurance",              precision: 8, scale: 2
    t.decimal "purchase_price",                precision: 8, scale: 2
    t.decimal "depreciation",                  precision: 8, scale: 2
    t.integer "registration_year", limit: 4
  end

  create_table "car_cost_tool_fuel_prices", force: :cascade do |t|
    t.string   "fuel_type",      limit: 255
    t.decimal  "price_in_pence",             precision: 10, scale: 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "car_cost_tool_user_data", force: :cascade do |t|
    t.string  "token",                   limit: 255
    t.integer "annual_mileage",          limit: 4
    t.integer "intended_ownership_term", limit: 4
  end

  add_index "car_cost_tool_user_data", ["token"], name: "index_car_cost_tool_user_data_on_token", unique: true, using: :btree

  create_table "car_cost_tool_ved_capacity_rates", force: :cascade do |t|
    t.integer  "cc_lower_limit",           limit: 4
    t.integer  "cc_upper_limit",           limit: 4
    t.integer  "annual_price_in_pence",    limit: 4
    t.integer  "six_month_price_in_pence", limit: 4
    t.string   "tax_year",                 limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "car_cost_tool_ved_co2_bands", force: :cascade do |t|
    t.string   "band",                     limit: 255
    t.string   "fuel_type",                limit: 255
    t.integer  "co2_lower_limit",          limit: 4
    t.integer  "co2_upper_limit",          limit: 4
    t.integer  "annual_price_in_pence",    limit: 4
    t.integer  "six_month_price_in_pence", limit: 4
    t.string   "tax_year",                 limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "corporate_partners", force: :cascade do |t|
    t.string   "name",            limit: 255, null: false
    t.string   "email",           limit: 255, null: false
    t.string   "tool_name",       limit: 255
    t.string   "tool_language",   limit: 255
    t.string   "tool_width_unit", limit: 255
    t.integer  "tool_width",      limit: 4,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cost_calculator_builder_calculators", force: :cascade do |t|
    t.string   "name",                              limit: 255
    t.string   "display_name",                      limit: 255
    t.date     "target_date"
    t.integer  "duration_in_days",                  limit: 4
    t.string   "duration_type",                     limit: 255
    t.string   "duration_label",                    limit: 255
    t.string   "summary_name",                      limit: 255
    t.text     "summary_description",               limit: 65535
    t.text     "summary_callout_note",              limit: 65535
    t.text     "final_balance_text",                limit: 65535
    t.text     "good_balance_summary",              limit: 65535
    t.text     "bad_balance_summary",               limit: 65535
    t.integer  "balance_threshold",                 limit: 4,     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",                              limit: 255
    t.boolean  "invert_threshold_value",                          default: false
    t.text     "good_balance_summary_after_amount", limit: 65535
    t.text     "bad_balance_summary_after_amount",  limit: 65535
    t.string   "countdown_precision",               limit: 255
  end

  add_index "cost_calculator_builder_calculators", ["slug"], name: "index_cost_calculator_builder_calculators_on_slug", unique: true, using: :btree

  create_table "cost_calculator_builder_call_to_actions", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.text     "text",          limit: 65535
    t.string   "url",           limit: 255
    t.integer  "calculator_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "value",         limit: 255,   default: "positive", null: false
    t.boolean  "nofollow",                    default: true
  end

  add_index "cost_calculator_builder_call_to_actions", ["calculator_id"], name: "index_cost_calculator_builder_call_to_actions_on_calculator_id", using: :btree

  create_table "cost_calculator_builder_expense_pages", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.string   "page_type",           limit: 255
    t.text     "description",         limit: 65535
    t.text     "callout_note",        limit: 65535
    t.text     "total_note",          limit: 65535
    t.boolean  "user_submitted_date"
    t.integer  "calculator_id",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "index",               limit: 4
    t.boolean  "allow_user_duration"
  end

  add_index "cost_calculator_builder_expense_pages", ["calculator_id"], name: "index_cost_calculator_builder_expense_pages_on_calculator_id", using: :btree

  create_table "cost_calculator_builder_expenses", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "expense_type",     limit: 255
    t.text     "help_text",        limit: 65535
    t.text     "instructive_text", limit: 65535
    t.integer  "min_value",        limit: 4,                    default: 0
    t.integer  "max_value",        limit: 4
    t.integer  "default_value",    limit: 4,                    default: 0
    t.string   "multiplier_text",  limit: 255
    t.decimal  "multiplier_value",               precision: 10
    t.integer  "expense_page_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "custom_duration",  limit: 4,                    default: 0, null: false
    t.boolean  "enable_more"
  end

  add_index "cost_calculator_builder_expenses", ["expense_page_id"], name: "index_cost_calculator_builder_expenses_on_expense_page_id", using: :btree

  create_table "csr_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "csr_id",                 limit: 255,              null: false
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
  end

  add_index "csr_users", ["email"], name: "index_csr_users_on_email", unique: true, using: :btree
  add_index "csr_users", ["reset_password_token"], name: "index_csr_users_on_reset_password_token", unique: true, using: :btree

  create_table "debt_advice_locator_organisation_awards", force: :cascade do |t|
    t.integer "organisation_standard_id", limit: 4
    t.integer "organisation_id",          limit: 4
  end

  create_table "debt_advice_locator_organisation_standards", force: :cascade do |t|
    t.string  "name", limit: 255
    t.boolean "free",             default: true
  end

  create_table "debt_advice_locator_organisations", force: :cascade do |t|
    t.string   "name",                                         limit: 255
    t.text     "address_street_address",                       limit: 65535
    t.string   "address_locality",                             limit: 255
    t.string   "address_region",                               limit: 255
    t.string   "address_postcode",                             limit: 255
    t.float    "lat",                                          limit: 24
    t.float    "lng",                                          limit: 24
    t.string   "email_address",                                limit: 255
    t.string   "website_address",                              limit: 255
    t.string   "minicom",                                      limit: 255
    t.text     "notes",                                        limit: 65535
    t.boolean  "provides_face_to_face",                                      default: false, null: false
    t.boolean  "provides_telephone",                                         default: false, null: false
    t.boolean  "provides_web",                                               default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "telephone_en",                                 limit: 255
    t.string   "telephone_cy",                                 limit: 255
    t.boolean  "region_england",                                             default: false, null: false
    t.boolean  "region_northern_ireland",                                    default: false, null: false
    t.boolean  "region_scotland",                                            default: false, null: false
    t.boolean  "region_wales",                                               default: false, null: false
    t.string   "website_address_text",                         limit: 255
    t.text     "notes_cy",                                     limit: 65535
    t.integer  "debt_advice_locator_organisation_standard_id", limit: 4
    t.boolean  "display_in_accredited_list",                                 default: false
  end

  add_index "debt_advice_locator_organisations", ["lat", "lng"], name: "dal_organisations_lat_lng", using: :btree
  add_index "debt_advice_locator_organisations", ["provides_face_to_face"], name: "dal_organisations_provides_face_to_face", using: :btree
  add_index "debt_advice_locator_organisations", ["provides_telephone"], name: "dal_organisations_provides_telephone", using: :btree
  add_index "debt_advice_locator_organisations", ["provides_web"], name: "dal_organisations_provides_web", using: :btree

  create_table "debt_free_day_calculator_calculations", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",       limit: 255
    t.string   "uuid",       limit: 255
  end

  add_index "debt_free_day_calculator_calculations", ["type"], name: "dfdc_calculations_type", using: :btree
  add_index "debt_free_day_calculator_calculations", ["uuid"], name: "dfdc_calculations_uuid", using: :btree

  create_table "debt_free_day_calculator_debts", force: :cascade do |t|
    t.string   "title",          limit: 255,                          default: ""
    t.decimal  "balance",                    precision: 10, scale: 2
    t.decimal  "apr",                        precision: 6,  scale: 2
    t.decimal  "repayment",                  precision: 10, scale: 2
    t.decimal  "months",                     precision: 10, scale: 2
    t.integer  "calculation_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",           limit: 255
    t.decimal  "cost",                       precision: 10, scale: 2
    t.decimal  "interest",                   precision: 10, scale: 2
  end

  add_index "debt_free_day_calculator_debts", ["type"], name: "dfdc_debts_type", using: :btree

  create_table "debt_health_answer_resources", force: :cascade do |t|
    t.integer  "answer_id",   limit: 4
    t.integer  "resource_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "debt_health_answer_resources", ["answer_id", "resource_id"], name: "debt_health_answers_resources_id", using: :btree

  create_table "debt_health_answers", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.integer  "question_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "score",       limit: 4,   default: 0
  end

  create_table "debt_health_categories", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "debt_health_questionnaires", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "debt_health_questions", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "row_order",   limit: 4,   default: 0
    t.integer  "category_id", limit: 4
    t.string   "heading",     limit: 255
  end

  create_table "debt_health_resources", force: :cascade do |t|
    t.string  "url",           limit: 255
    t.string  "title",         limit: 255
    t.string  "resource_type", limit: 255
    t.integer "score",         limit: 4,   default: 0
    t.string  "external_id",   limit: 255
    t.integer "result_id",     limit: 4
  end

  create_table "debt_health_responses", force: :cascade do |t|
    t.integer  "question_id",      limit: 4
    t.integer  "answer_id",        limit: 4
    t.integer  "questionnaire_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "debt_health_results", force: :cascade do |t|
    t.text     "body",       limit: 65535
    t.text     "intro",      limit: 65535
    t.integer  "score_min",  limit: 4
    t.integer  "score_max",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quiz_audit_records", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.string   "resource_type", limit: 255
    t.integer  "resource_id",   limit: 4
    t.string   "action",        limit: 255
    t.datetime "created_at"
  end

  add_index "quiz_audit_records", ["resource_type", "resource_id"], name: "index_quiz_audit_records_on_resource", using: :btree

  create_table "quiz_partners", force: :cascade do |t|
    t.string   "name",                      limit: 255
    t.string   "slug",                      limit: 255
    t.string   "background_color",          limit: 255
    t.string   "primary_color",             limit: 255
    t.string   "secondary_color",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sidenav_header_color",      limit: 255
    t.string   "sidenav_header_text_color", limit: 255
    t.string   "banner_text_color",         limit: 255
    t.string   "question_heading_color",    limit: 255
    t.string   "button_color",              limit: 255
    t.string   "button_text_color",         limit: 255
  end

  add_index "quiz_partners", ["slug"], name: "index_quiz_partners_on_slug", unique: true, using: :btree

  create_table "quiz_player_responses", force: :cascade do |t|
    t.integer  "response",    limit: 4
    t.boolean  "correct"
    t.boolean  "demo"
    t.integer  "player_id",   limit: 4
    t.integer  "question_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quiz_players", force: :cascade do |t|
    t.integer  "widget_id",  limit: 4
    t.boolean  "demo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quiz_questions", force: :cascade do |t|
    t.integer  "quiz_id",               limit: 4
    t.text     "question_en",           limit: 65535
    t.text     "question_cy",           limit: 65535
    t.string   "image_uid",             limit: 255
    t.string   "answer_1_en",           limit: 255
    t.string   "answer_2_en",           limit: 255
    t.string   "answer_3_en",           limit: 255
    t.string   "answer_4_en",           limit: 255
    t.string   "answer_1_cy",           limit: 255
    t.string   "answer_2_cy",           limit: 255
    t.string   "answer_3_cy",           limit: 255
    t.string   "answer_4_cy",           limit: 255
    t.integer  "correct_answer_number", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_url",             limit: 255
  end

  add_index "quiz_questions", ["quiz_id"], name: "index_quiz_questions_on_quiz_id", using: :btree

  create_table "quiz_quiz_users", force: :cascade do |t|
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.boolean  "admin",                              default: false
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quiz_quiz_users", ["email"], name: "index_quiz_quiz_users_on_email", unique: true, using: :btree
  add_index "quiz_quiz_users", ["reset_password_token"], name: "index_quiz_quiz_users_on_reset_password_token", unique: true, using: :btree

  create_table "quiz_quizzes", force: :cascade do |t|
    t.string   "name_en",                     limit: 255
    t.string   "name_cy",                     limit: 255
    t.string   "slogan_en",                   limit: 255
    t.string   "slogan_cy",                   limit: 255
    t.string   "score_summary_low_en",        limit: 255
    t.string   "score_summary_mid_en",        limit: 255
    t.string   "score_summary_high_en",       limit: 255
    t.string   "score_summary_low_cy",        limit: 255
    t.string   "score_summary_mid_cy",        limit: 255
    t.string   "score_summary_high_cy",       limit: 255
    t.boolean  "archived",                                  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "score_summary_low_blurb_en",  limit: 65535
    t.text     "score_summary_mid_blurb_en",  limit: 65535
    t.text     "score_summary_high_blurb_en", limit: 65535
    t.text     "score_summary_low_blurb_cy",  limit: 65535
    t.text     "score_summary_mid_blurb_cy",  limit: 65535
    t.text     "score_summary_high_blurb_cy", limit: 65535
  end

  create_table "quiz_widget_hosts", force: :cascade do |t|
    t.integer  "widget_id",  limit: 4
    t.text     "url",        limit: 65535
    t.string   "name",       limit: 255
    t.datetime "created_at"
  end

  add_index "quiz_widget_hosts", ["widget_id"], name: "index_quiz_widget_hosts_on_widget_id", using: :btree

  create_table "quiz_widget_snippets", force: :cascade do |t|
    t.integer "widget_id",   limit: 4
    t.integer "question_id", limit: 4
    t.string  "slug",        limit: 255
    t.text    "value",       limit: 65535
  end

  create_table "quiz_widgets", force: :cascade do |t|
    t.integer  "quiz_id",                   limit: 4
    t.integer  "partner_id",                limit: 4
    t.text     "feed_url_en",               limit: 65535
    t.text     "feed_url_cy",               limit: 65535
    t.text     "front_page_text_en",        limit: 65535
    t.text     "front_page_text_cy",        limit: 65535
    t.string   "image_uid",                 limit: 255
    t.string   "background_color",          limit: 255
    t.string   "primary_color",             limit: 255
    t.string   "secondary_color",           limit: 255
    t.boolean  "no_follow"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_url_1",               limit: 255
    t.string   "image_url_2",               limit: 255
    t.string   "image_url_3",               limit: 255
    t.string   "sidenav_header_color",      limit: 255
    t.string   "sidenav_header_text_color", limit: 255
    t.string   "banner_text_color",         limit: 255
    t.string   "question_heading_color",    limit: 255
    t.string   "button_color",              limit: 255
    t.string   "button_text_color",         limit: 255
    t.boolean  "show_mas_logo",                           default: false
  end

  add_index "quiz_widgets", ["partner_id"], name: "index_quiz_widgets_on_partner_id", using: :btree
  add_index "quiz_widgets", ["quiz_id"], name: "index_quiz_widgets_on_quiz_id", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255,   null: false
    t.text     "data",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                   limit: 255,   default: "",    null: false
    t.string   "encrypted_password",      limit: 255,   default: ""
    t.string   "reset_password_token",    limit: 255
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",           limit: 4,     default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",      limit: 255
    t.string   "last_sign_in_ip",         limit: 255
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.boolean  "accept_terms_conditions"
    t.string   "first_name",              limit: 255
    t.string   "last_name",               limit: 255
    t.string   "password_salt",           limit: 255
    t.string   "post_code",               limit: 255
    t.string   "age_range",               limit: 255
    t.string   "gender",                  limit: 255
    t.boolean  "newsletter_subscription",               default: false
    t.string   "customer_id",             limit: 255
    t.text     "health_check_result",     limit: 65535
    t.boolean  "active",                                default: true
    t.date     "date_of_birth"
    t.string   "confirmation_token",      limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",       limit: 255
    t.string   "csr_id",                  limit: 255
    t.string   "invitation_token",        limit: 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit",        limit: 4
    t.integer  "invited_by_id",           limit: 4
    t.string   "invited_by_type",         limit: 255
    t.integer  "failed_attempts",         limit: 4,     default: 0
    t.string   "unlock_token",            limit: 255
    t.datetime "locked_at"
    t.string   "goal_statement",          limit: 255
    t.string   "goal_deadline",           limit: 255
    t.string   "contact_number",          limit: 255
    t.boolean  "opt_in_for_research",                   default: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
