namespace :users do

desc "Find and encrypt Users with unencrypted PII values"
task encrypt_personal_data: :environment do
  User.reset_column_information
  User.where(id: 177620..177715).each do |i|
   #this will set the encrypted_reply based on attr_encrypted
     i.email = i.email_old
     i.first_name = i.first_name_old
     i.last_name = i.last_name_old
     i.post_code = i.post_code_old
     i.contact_number = i.contact_number_old
     i.age_range = i.age_range_old
     i.date_of_birth = i.date_of_birth_old
     i.compute_email_bidx
     i.compute_first_name_bidx
     i.compute_last_name_bidx
     i.save!
    end
  end
end
