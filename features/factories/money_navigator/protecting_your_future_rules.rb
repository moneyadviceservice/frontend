require_relative 'rules_factory_common'

FactoryBot.define do
  factory :protecting_your_future, parent: :answers do

    factory :S10_H1_cancelling_insurance, traits: [:country, :S10_H1_cancelling_insurance_answers]

    trait :S10_H1_cancelling_insurance_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', [], nil) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', ['a1', 'a3'], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

  end
end
