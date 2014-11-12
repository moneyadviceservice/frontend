FactoryGirl.define do
  factory :user, class: User do
    first_name 'Tenacious'
    sequence(:email) { |i| "tenacious#{i}@example.com" }
    password 'password'
    post_code 'NE1 6EE'
  end
end
