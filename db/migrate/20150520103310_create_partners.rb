class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :tool_name
      t.string :tool_language
      t.string :tool_width_unit
      t.integer :tool_width, null: false

      t.timestamps
    end
  end
end
