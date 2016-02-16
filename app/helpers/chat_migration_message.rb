module ChatMigrationMessage

  MIGRATION_DATE = Date.new(2016, 2, 6)

  def display_chat_migration_message?
    Date.today == MIGRATION_DATE
  end

  def alternate_hours_active?
    display_chat_migration_message?
  end
end
