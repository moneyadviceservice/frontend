FactoryGirl.define do
  factory :action_plan, class: Core::ActionPlan do
    id { Faker::Lorem.words.join('-') }
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph(1) }
    body { '<p>' + Faker::Lorem.paragraphs.join('</p><p> ') + '</p>' }

    initialize_with { new(id) }

    factory :action_plan_hash, class: Hash do
      type 'action_plan'

      initialize_with do
        Hash[attributes.map { |key, value| [key.to_s, value] }]
      end
    end
  end
end
