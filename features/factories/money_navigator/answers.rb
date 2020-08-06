include Symbols
require_relative 'rules_factory_common'

FactoryBot.define do
  factory :answers, class: Questions do

    country_answer_codes = HashWithIndifferentAccess.new(england: 'a1', ni: 'a2', scotland: 'a3', wales: 'a4')

    transient do
      target_region {[ 'england' ]}
    end

    trait :country do
      q0 { answers_with_entropy('q0', target_region.map {|country| country_answer_codes[country]}, []) }
    end

  end
end
