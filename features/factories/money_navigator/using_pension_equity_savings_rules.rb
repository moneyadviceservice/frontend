require_relative 'rules_factory_common'

FactoryBot.define do
  factory :using_pension_equity_savings, parent: :answers do

    factory :S9_H1_pensions_debt, traits: [:country, :S9_H1_pensions_debt_answers]
    factory :S9_H2_equity_mortage_debt, traits: [:country, :S9_H2_equity_mortage_debt_answers]
    factory :S9_H3_savings_debt, traits: [:country, :S9_H3_savings_debt_answers]

    trait :S9_H1_pensions_debt_answers do
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
      q12 { answers_with_entropy('q12', ['a2'], []) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S9_H2_equity_mortage_debt_answers do
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
      q12 { answers_with_entropy('q12', ['a1', 'a3'], []) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S9_H3_savings_debt_answers do
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
      q12 { answers_with_entropy('q12', ['a4'], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

  end
end
