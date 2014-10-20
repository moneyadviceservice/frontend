class AddGoalStatementAndDeadlineToUser < ActiveRecord::Migration
  def change
    add_column :users, :goal_statement, :string
    add_column :users, :goal_deadline, :string
  end
end
