class EncryptDob < ActiveRecord::Migration
  def change
    unless column_exists? :users, :encrypted_date_of_birth
      add_column :users, :encrypted_date_of_birth, :string
    end
    unless column_exists? :users, :encrypted_date_of_birth_iv
      add_column :users, :encrypted_date_of_birth_iv, :string
    end
    if column_exists? :users, :date_of_birth
      rename_column :users, :date_of_birth, :date_of_birth_old
    end
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
