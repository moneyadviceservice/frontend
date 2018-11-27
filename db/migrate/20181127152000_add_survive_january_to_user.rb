class AddSurviveJanuaryToUser < ActiveRecord::Migration
  def change
    add_column :users, :survive_january, :boolean
  end
end
