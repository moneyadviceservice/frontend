class SetOptInForResearchToTrueByDefault < ActiveRecord::Migration
  def change
    change_column :users, :opt_in, :boolean, default: true
  end
end
