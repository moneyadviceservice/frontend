require 'core/entities/category'

FactoryGirl.define do
  factory :category, class: Core::Category do
    sequence(:id) { |i| "category-#{i}" }
    title { id.capitalize.sub(/-/, ' ') }
    description { Faker::Lorem.paragraph(1) }
    contents []

    initialize_with { new(id) }
  end
end
