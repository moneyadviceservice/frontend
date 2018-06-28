class AddEncryptedFields < ActiveRecord::Migration
  def up
    unless column_exists? :users, :encrypted_first_name
      add_column :users, :encrypted_first_name, :string 
    end
    unless column_exists? :users, :encrypted_first_name_iv
      add_column :users, :encrypted_first_name_iv, :string  
    end
    unless column_exists? :users, :encrypted_first_name_bidx
      add_column :users, :encrypted_first_name_bidx, :string 
    end
    unless column_exists? :users, :encrypted_last_name
      add_column :users, :encrypted_last_name, :string 
    end
    unless column_exists? :users, :encrypted_last_name_iv 
      add_column :users, :encrypted_last_name_iv, :string
    end
    unless column_exists? :users, :encrypted_last_name_bidx
      add_column :users, :encrypted_last_name_bidx, :string
    end
    unless column_exists? :users, :encrypted_email 
      add_column :users, :encrypted_email, :string
    end
    unless column_exists? :users, :encrypted_email_iv
      add_column :users, :encrypted_email_iv, :string 
    end
    unless column_exists? :users, :encrypted_email_bidx 
      add_column :users, :encrypted_email_bidx, :string
    end
    unless column_exists? :users, :encrypted_post_code
      add_column :users, :encrypted_post_code, :string 
    end
    unless column_exists? :users, :encrypted_post_code_iv
      add_column :users, :encrypted_post_code_iv, :string 
    end
    unless column_exists? :users, :encrypted_contact_number 
      add_column :users, :encrypted_contact_number, :string
    end
    unless column_exists? :users, :encrypted_contact_number_iv
      add_column :users, :encrypted_contact_number_iv, :string 
    end
    unless column_exists? :users, :encrypted_age_range
      add_column :users, :encrypted_age_range, :string 
    end
    unless column_exists? :users, :encrypted_age_range_iv
      add_column :users, :encrypted_age_range_iv, :string 
    end
    unless column_exists? :users, :encrypted_date_of_birth
      add_column :users, :encrypted_date_of_birth, :string
    end
    unless column_exists? :users, :encrypted_date_of_birth_iv
      add_column :users, :encrypted_date_of_birth_iv, :string
    end
    # blind index
    unless index_exists? :users, :encrypted_first_name_bidx, unique: false
      add_index :users, :encrypted_first_name_bidx, unique: false
    end
    unless index_exists? :users, :encrypted_last_name_bidx, unique: false
      add_index :users, :encrypted_last_name_bidx, unique: false
    end
    unless index_exists? :users, :encrypted_email_bidx, unique: true
      add_index :users, :encrypted_email_bidx, unique: true
    end
    # rename old columns
    if column_exists? :users, :email
      rename_column :users, :email, :email_old
    end
    if column_exists? :users, :first_name
      rename_column :users, :first_name, :first_name_old
    end
    if column_exists? :users, :last_name
      rename_column :users, :last_name, :last_name_old
    end
    if column_exists? :users, :post_code
      rename_column :users, :post_code, :post_code_old
    end
    if column_exists? :users, :contact_number
      rename_column :users, :contact_number, :contact_number_old
    end
    if column_exists? :users, :age_range
      rename_column :users, :age_range, :age_range_old
    end
    if column_exists? :users, :date_of_birth
      rename_column :users, :date_of_birth, :date_of_birth_old
    end
    
    User.reset_column_information
     User.find_each do |instance|
      #this will set the encrypted_reply based on attr_encrypted
        instance.email = instance.email_old
        instance.first_name = instance.first_name_old
        instance.last_name = instance.last_name_old
        instance.post_code = instance.post_code_old
        instance.contact_number = instance.contact_number_old
        instance.age_range = instance.age_range_old
        instance.date_of_birth = instance.date_of_birth_old
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
    rename_column :users, :date_of_birth_old, :date_of_birth
  end
end
