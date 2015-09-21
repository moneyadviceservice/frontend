class AddOptInFieldToUsers < ActiveRecord::Migration
  def change
    add_column :users, :opt_in_for_research, :boolean, default: true
  end
end
