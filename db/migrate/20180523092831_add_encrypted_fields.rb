class AddEncryptedFields < ActiveRecord::Migration
  def change
    add_column :users, :encrypted_first_name, :string
    add_column :users, :encrypted_first_name_iv, :string
    add_column :users, :encrypted_first_name_bidx, :string
    add_column :users, :encrypted_last_name, :string
    add_column :users, :encrypted_last_name_iv, :string
    add_column :users, :encrypted_last_name_bidx, :string
    add_column :users, :encrypted_email, :string
    add_column :users, :encrypted_email_iv, :string
    add_column :users, :encrypted_email_bidx, :string
    add_column :users, :encrypted_post_code, :string
    add_column :users, :encrypted_post_code_iv, :string
    add_column :users, :encrypted_contact_number, :string
    add_column :users, :encrypted_contact_number_iv, :string
    add_column :users, :encrypted_age_range, :string
    add_column :users, :encrypted_age_range_iv, :string
    # blind index
    add_index :users, :encrypted_first_name_bidx, unique: true
    add_index :users, :encrypted_last_name_bidx, unique: true
    add_index :users, :encrypted_email_bidx, unique: true
    # rename old columns
    rename_column :users, :email, :email_old
    rename_column :users, :first_name, :first_name_old
    rename_column :users, :last_name, :last_name_old
    rename_column :users, :post_code, :post_code_old
    rename_column :users, :contact_number, :contact_number_old
    rename_column :users, :age_range, :age_range_old

    User.reset_column_information
     User.find_each do |instance|
     #this will set the encrypted_reply based on attr_encrypted
       User.email = user.email_old
       User.first_name = user.first_name_old
       User.last_name = user.last_name_old
       User.post_code = user.post_code_old
       User.contact_number = user.contact_number_old
       User.age_range = user.age_range_old
       User.save!
     end
  end
end
