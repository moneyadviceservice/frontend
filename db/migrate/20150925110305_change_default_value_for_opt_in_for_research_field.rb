class ChangeDefaultValueForOptInForResearchField < ActiveRecord::Migration
  def change
    change_column :users, :opt_in_for_research, :boolean, default: false
  end
end
