include Symbols
require_relative 'rules_factory_common'

FactoryBot.define do
  factory :payment_holiday_rule_answers, parent: :answers do

    factory :S2_H1_holiday_mortgage_payment_severe, traits: [:country, :S2_H1_holiday_mortgage_payment_severe_answers]
    factory :S2_H1_holiday_mortgage_payment_temp_worried, traits: [:country, :S2_H1_holiday_mortgage_payment_temp_worried_answers]
    factory :S2_H1_holiday_mortgage_payment_temp_normal, traits: [:country, :S2_H1_holiday_mortgage_payment_temp_normal_answers]
    factory :S2_H1_holiday_mortgage_payment_no_change, traits: [:country, :S2_H1_holiday_mortgage_payment_no_change_answers]

    factory :S2_H2_holiday_personal_loan_severe, traits: [:country, :S2_H2_holiday_personal_loan_severe_answers]
    factory :S2_H2_holiday_personal_loan_temp_worried, traits: [:country, :S2_H2_holiday_personal_loan_temp_worried_answers]
    factory :S2_H2_holiday_personal_loan_temp_normal, traits: [:country, :S2_H2_holiday_personal_loan_temp_normal_answers]
    factory :S2_H2_holiday_personal_loan_no_change, traits: [:country, :S2_H2_holiday_personal_loan_no_change_answers]

    factory :S2_H3_holiday_credit_card_severe, traits: [:country, :S2_H3_holiday_credit_card_severe_answers]
    factory :S2_H3_holiday_credit_card_temp_worried, traits: [:country, :S2_H3_holiday_credit_card_temp_worried_answers]
    factory :S2_H3_holiday_credit_card_temp_normal, traits: [:country, :S2_H3_holiday_credit_card_temp_normal_answers]
    factory :S2_H3_holiday_credit_card_no_change, traits: [:country, :S2_H3_holiday_credit_card_no_change_answers]

    trait :S2_H1_holiday_mortgage_payment_severe_answers do
      q1 { answers_with_entropy('q1', [], nil)  }
      q2 { answers_with_entropy('q2', [], nil)  }
      q3 { answers_with_entropy('q3', [], nil)  }
      q4 { answers_with_entropy('q4', ['a1'], [])}
      q5 { answers_with_entropy('q5', [], nil)  }
      q6 { answers_with_entropy('q6', [], nil)}
      q7 { answers_with_entropy('q7', [], nil )}
      q8 { answers_with_entropy('q8', ['a1'], [])  }
      q9 { answers_with_entropy('q9', [], nil) }
      q10 { answers_with_entropy('q10', [], nil) }
      q11 { answers_with_entropy('q11', [], nil)  }
      q12 { answers_with_entropy('q12', [], nil)  }
      q13 { answers_with_entropy('q13', [], nil)  }
      q14 { answers_with_entropy('q14', [], nil)  }
    end

    trait :S2_H1_holiday_mortgage_payment_temp_worried_answers do
      q1 { answers_with_entropy('q1', [], nil)  }
      q2 { answers_with_entropy('q2', [], nil)  }
      q3 { answers_with_entropy('q3', [], nil)  }
      q4 { answers_with_entropy('q4', ['a2'], [])}
      q5 { answers_with_entropy('q5', [], nil)  }
      q6 { answers_with_entropy('q6', [], nil)}
      q7 { answers_with_entropy('q7', [], nil )}
      q8 { answers_with_entropy('q8', ['a1'], [])  }
      q9 { answers_with_entropy('q9', [], nil) }
      q10 { answers_with_entropy('q10', [], nil) }
      q11 { answers_with_entropy('q11', [], nil)  }
      q12 { answers_with_entropy('q12', [], nil)  }
      q13 { answers_with_entropy('q13', [], nil)  }
      q14 { answers_with_entropy('q14', [], nil)  }
    end

    trait :S2_H1_holiday_mortgage_payment_temp_normal_answers do
      q1 { answers_with_entropy('q1', [], nil)  }
      q2 { answers_with_entropy('q2', [], nil)  }
      q3 { answers_with_entropy('q3', [], nil)  }
      q4 { answers_with_entropy('q4', ['a3'], [])}
      q5 { answers_with_entropy('q5', [], nil)  }
      q6 { answers_with_entropy('q6', [], nil)}
      q7 { answers_with_entropy('q7', [], nil )}
      q8 { answers_with_entropy('q8', ['a1'], [])  }
      q9 { answers_with_entropy('q9', [], nil) }
      q10 { answers_with_entropy('q10', [], nil) }
      q11 { answers_with_entropy('q11', [], nil)  }
      q12 { answers_with_entropy('q12', [], nil)  }
      q13 { answers_with_entropy('q13', [], nil)  }
      q14 { answers_with_entropy('q14', [], nil)  }
    end

    trait :S2_H1_holiday_mortgage_payment_no_change_answers do
      q1 { answers_with_entropy('q1', [], nil)  }
      q2 { answers_with_entropy('q2', [], nil)  }
      q3 { answers_with_entropy('q3', [], nil)  }
      q4 { answers_with_entropy('q4', ['a4'], [])}
      q5 { answers_with_entropy('q5', [], nil)  }
      q6 { answers_with_entropy('q6', [], nil)}
      q7 { answers_with_entropy('q7', [], nil )}
      q8 { answers_with_entropy('q8', ['a1'], [])  }
      q9 { answers_with_entropy('q9', [], nil) }
      q10 { answers_with_entropy('q10', [], nil) }
      q11 { answers_with_entropy('q11', [], nil)  }
      q12 { answers_with_entropy('q12', [], nil)  }
      q13 { answers_with_entropy('q13', [], nil)  }
      q14 { answers_with_entropy('q14', [], nil)  }
    end

    trait :S2_H2_holiday_personal_loan_severe_answers do
      q1 { answers_with_entropy('q1', [], nil)  }
      q2 { answers_with_entropy('q2', [], nil)  }
      q3 { answers_with_entropy('q3', [], nil)  }
      q4 { answers_with_entropy('q4', ['a1'], [])}
      q5 { answers_with_entropy('q5', [], nil)  }
      q6 { answers_with_entropy('q6', [], nil)}
      q7 { answers_with_entropy('q7', [], nil )}
      q8 { answers_with_entropy('q8', ['a2'], [])  }
      q9 { answers_with_entropy('q9', [], nil) }
      q10 { answers_with_entropy('q10', [], nil) }
      q11 { answers_with_entropy('q11', [], nil)  }
      q12 { answers_with_entropy('q12', [], nil)  }
      q13 { answers_with_entropy('q13', [], nil)  }
      q14 { answers_with_entropy('q14', [], nil)  }
    end

    trait :S2_H2_holiday_personal_loan_temp_worried_answers do
      q1 { answers_with_entropy('q1', [], nil)  }
      q2 { answers_with_entropy('q2', [], nil)  }
      q3 { answers_with_entropy('q3', [], nil)  }
      q4 { answers_with_entropy('q4', ['a2'], [])}
      q5 { answers_with_entropy('q5', [], nil)  }
      q6 { answers_with_entropy('q6', [], nil)}
      q7 { answers_with_entropy('q7', [], nil )}
      q8 { answers_with_entropy('q8', ['a2'], [])  }
      q9 { answers_with_entropy('q9', [], nil) }
      q10 { answers_with_entropy('q10', [], nil) }
      q11 { answers_with_entropy('q11', [], nil)  }
      q12 { answers_with_entropy('q12', [], nil)  }
      q13 { answers_with_entropy('q13', [], nil)  }
      q14 { answers_with_entropy('q14', [], nil)  }
    end

    trait :S2_H2_holiday_personal_loan_temp_normal_answers do
      q1 { answers_with_entropy('q1', [], nil)  }
      q2 { answers_with_entropy('q2', [], nil)  }
      q3 { answers_with_entropy('q3', [], nil)  }
      q4 { answers_with_entropy('q4', ['a3'], [])}
      q5 { answers_with_entropy('q5', [], nil)  }
      q6 { answers_with_entropy('q6', [], nil)}
      q7 { answers_with_entropy('q7', [], nil )}
      q8 { answers_with_entropy('q8', ['a2'], [])  }
      q9 { answers_with_entropy('q9', [], nil) }
      q10 { answers_with_entropy('q10', [], nil) }
      q11 { answers_with_entropy('q11', [], nil)  }
      q12 { answers_with_entropy('q12', [], nil)  }
      q13 { answers_with_entropy('q13', [], nil)  }
      q14 { answers_with_entropy('q14', [], nil)  }
    end

    trait :S2_H2_holiday_personal_loan_no_change_answers do
      q1 { answers_with_entropy('q1', [], nil)  }
      q2 { answers_with_entropy('q2', [], nil)  }
      q3 { answers_with_entropy('q3', [], nil)  }
      q4 { answers_with_entropy('q4', ['a4'], [])}
      q5 { answers_with_entropy('q5', [], nil)  }
      q6 { answers_with_entropy('q6', [], nil)}
      q7 { answers_with_entropy('q7', [], nil )}
      q8 { answers_with_entropy('q8', ['a2'], [])  }
      q9 { answers_with_entropy('q9', [], nil) }
      q10 { answers_with_entropy('q10', [], nil) }
      q11 { answers_with_entropy('q11', [], nil)  }
      q12 { answers_with_entropy('q12', [], nil)  }
      q13 { answers_with_entropy('q13', [], nil)  }
      q14 { answers_with_entropy('q14', [], nil)  }
    end

    trait :S2_H3_holiday_credit_card_severe_answers do
      q1 { answers_with_entropy('q1', [], nil)  }
      q2 { answers_with_entropy('q2', [], nil)  }
      q3 { answers_with_entropy('q3', [], nil)  }
      q4 { answers_with_entropy('q4', ['a1'], [])}
      q5 { answers_with_entropy('q5', [], nil)  }
      q6 { answers_with_entropy('q6', [], nil)}
      q7 { answers_with_entropy('q7', [], nil )}
      q8 { answers_with_entropy('q8', ['a3'], [])  }
      q9 { answers_with_entropy('q9', [], nil) }
      q10 { answers_with_entropy('q10', [], nil) }
      q11 { answers_with_entropy('q11', [], nil)  }
      q12 { answers_with_entropy('q12', [], nil)  }
      q13 { answers_with_entropy('q13', [], nil)  }
      q14 { answers_with_entropy('q14', [], nil)  }
    end

    trait :S2_H3_holiday_credit_card_temp_worried_answers do
      q1 { answers_with_entropy('q1', [], nil)  }
      q2 { answers_with_entropy('q2', [], nil)  }
      q3 { answers_with_entropy('q3', [], nil)  }
      q4 { answers_with_entropy('q4', ['a2'], [])}
      q5 { answers_with_entropy('q5', [], nil)  }
      q6 { answers_with_entropy('q6', [], nil)}
      q7 { answers_with_entropy('q7', [], nil )}
      q8 { answers_with_entropy('q8', ['a3'], [])  }
      q9 { answers_with_entropy('q9', [], nil) }
      q10 { answers_with_entropy('q10', [], nil) }
      q11 { answers_with_entropy('q11', [], nil)  }
      q12 { answers_with_entropy('q12', [], nil)  }
      q13 { answers_with_entropy('q13', [], nil)  }
      q14 { answers_with_entropy('q14', [], nil)  }
    end

    trait :S2_H3_holiday_credit_card_temp_normal_answers do
      q1 { answers_with_entropy('q1', [], nil)  }
      q2 { answers_with_entropy('q2', [], nil)  }
      q3 { answers_with_entropy('q3', [], nil)  }
      q4 { answers_with_entropy('q4', ['a3'], [])}
      q5 { answers_with_entropy('q5', [], nil)  }
      q6 { answers_with_entropy('q6', [], nil)}
      q7 { answers_with_entropy('q7', [], nil )}
      q8 { answers_with_entropy('q8', ['a3'], [])  }
      q9 { answers_with_entropy('q9', [], nil) }
      q10 { answers_with_entropy('q10', [], nil) }
      q11 { answers_with_entropy('q11', [], nil)  }
      q12 { answers_with_entropy('q12', [], nil)  }
      q13 { answers_with_entropy('q13', [], nil)  }
      q14 { answers_with_entropy('q14', [], nil)  }
    end

    trait :S2_H3_holiday_credit_card_no_change_answers do
      q1 { answers_with_entropy('q1', [], nil)  }
      q2 { answers_with_entropy('q2', [], nil)  }
      q3 { answers_with_entropy('q3', [], nil)  }
      q4 { answers_with_entropy('q4', ['a4'], [])}
      q5 { answers_with_entropy('q5', [], nil)  }
      q6 { answers_with_entropy('q6', [], nil)}
      q7 { answers_with_entropy('q7', [], nil )}
      q8 { answers_with_entropy('q8', ['a3'], [])  }
      q9 { answers_with_entropy('q9', [], nil) }
      q10 { answers_with_entropy('q10', [], nil) }
      q11 { answers_with_entropy('q11', [], nil)  }
      q12 { answers_with_entropy('q12', [], nil)  }
      q13 { answers_with_entropy('q13', [], nil)  }
      q14 { answers_with_entropy('q14', [], nil)  }
    end
  end
end
