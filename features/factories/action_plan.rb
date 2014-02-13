require 'core/entities/action_plan'

FactoryGirl.define do
  factory :action_plan, class: Core::ActionPlan do
    id { Faker::Lorem.words.join('-') }
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph(1) }
    body { '<p>' + Faker::Lorem.paragraphs.join('</p><p> ') + '</p>' }

    initialize_with { new(id) }
  end
end
