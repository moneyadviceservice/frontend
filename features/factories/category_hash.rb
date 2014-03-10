FactoryGirl.define do
  factory :category_hash, class: Hash, parent: :category do
    initialize_with do
      Hash[attributes.map { |key, value| [key.to_s, value] }]
    end
  end
end
