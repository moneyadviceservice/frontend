class DropOldPublicWebsiteTables < ActiveRecord::Migration
  def up
    old_tables = %w( action_items
        divorce_and_separation_tool_states
        external_actions
        isa_alerts
        page_views
        partner_polling_partners
        partner_polling_audit_records
        partner_polling_poll_users
        partner_polling_polls
        partner_polling_redirections
        partner_polling_votes
        partner_polling_widget_hosts
        partner_polling_widgets
        partners_agreements
        student_money_tips_audit_records
        student_money_tips_scenarios
        student_money_tips_scenarios_tools
        student_money_tips_snippets
        student_money_tips_tips
        student_money_tips_tips_users
        student_money_tips_tools
        student_money_tips_widget_hosts
        survey_responses
        topics
        topics_users)

    old_tables.each do |table_name|
      drop_table :table_name if ActiveRecord::Base.connection.table_exists? table_name
    end
  end

  def down
    fail ActiveRecord::IrreversibleMigration, "can't recover old public website tables"
  end
end
