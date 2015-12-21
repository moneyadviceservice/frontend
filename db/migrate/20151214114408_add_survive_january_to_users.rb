class AddSurviveJanuaryToUsers < ActiveRecord::Migration
  def change
    add_column :users, :survive_january, :boolean, default: false
  end
end
