begin
  require 'faker'

  Faker::Config.locale = 'en-GB'

  desc 'Creates a number of Users which will trigger delayed_jobs'
  task :crm_load_test, [:users_n] => [:environment] do |task, options|
    counter = 0
    options.users_n.to_i.times do
      first_name = Faker::Name.first_name
      u = User.create(
        first_name: first_name ,
        post_code: Faker::Address.postcode,
        email: Faker::Internet.email(first_name),
        password: Faker::Internet.password(8)
      )
      counter += 1 if u.save
    end
    Rails.logger.info "CREATED === #{counter} Users ==="
  end
rescue LoadError
end
