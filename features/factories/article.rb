require 'core/entities/article'

FactoryGirl.define do
  factory :article, class: Core::Article do
    id { Faker::Lorem.words.join('-') }
    url { "http://example.com/en/articles/#{id}" }
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph(1) }
    body { '<p>' + Faker::Lorem.paragraphs.join('</p><p>') + '</p>' }

    initialize_with { new(id) }
  end
end
