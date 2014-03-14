require 'core/entities/article'

FactoryGirl.define do
  factory :article, class: Core::Article do
    id { Faker::Lorem.words.join('-') }
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph(1) }
    body { '<p>' + Faker::Lorem.paragraphs.join('</p><p> ') + '</p>' }

    initialize_with { new(id) }

    factory :article_hash, class: Hash do
      type 'guide'

      initialize_with do
        Hash[attributes.map { |key, value| [key.to_s, value] }]
      end
    end
  end
end
