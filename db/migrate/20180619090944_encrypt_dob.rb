class EncryptDob < ActiveRecord::Migration
  def change
    add_column :users, :encrypted_date_of_birth, :string
    add_column :users, :encrypted_date_of_birth_iv, :string
    rename_column :users, :date_of_birth, :date_of_birth_old

    User.reset_column_information
     User.find_each do |instance|
      #this will set the encrypted_reply based on attr_encrypted
        instance.date_of_birth = instance.date_of_birth_old
        instance.save!
     end
  end

  def down
    rename_column :users, :date_of_birth_old, :date_of_birth
  end
end
