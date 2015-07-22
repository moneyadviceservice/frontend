class ChangeOptInColumnInUser < ActiveRecord::Migration
  def change
    rename_column :users, :opt_in, :opt_in_for_research
  end
end
