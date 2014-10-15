class AddGoalTextAndDateToUser < ActiveRecord::Migration
  def change
    add_column :users, :goal_text, :string
    add_column :users, :goal_date, :string
  end
end
