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
    add_index :users, :encrypted_first_name_bidx, unique: false
    add_index :users, :encrypted_last_name_bidx, unique: false
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
        instance.email = instance.email_old
        instance.first_name = instance.first_name_old
        instance.last_name = instance.last_name_old
        instance.post_code = instance.post_code_old
        instance.contact_number = instance.contact_number_old
        instance.age_range = instance.age_range_old
        instance.compute_email_bidx
        instance.compute_first_name_bidx
        instance.compute_last_name_bidx
        instance.save!
     end
  end
  def down
    rename_column :users, :email_old, :email
    rename_column :users, :first_name_old, :first_name
    rename_column :users, :last_name_old, :last_name
    rename_column :users, :post_code_old, :post_code
    rename_column :users, :contact_number_old, :contact_number
    rename_column :users, :age_range_old, :age_range
  end
end
