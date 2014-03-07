FactoryGirl.define do
  factory :category_hash, class: Hash do
    sequence(:id) { |i| "category-#{i}" }
    title { id.capitalize.sub(/-/, ' ') }
    contents []

    initialize_with do
      Hash[attributes.map { |key, value| [key.to_s, value] }]
    end
  end
end
