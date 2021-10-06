require_relative 'rules_factory_common'

FactoryBot.define do
  factory :urgent_cta_rules_answers, parent: :answers do

    factory :S1_H1_debt_advice, traits: [:country, :S1_H1_debt_advice_answers]
    factory :S1_H3_self_employed_debt_advice, traits: [:country, :S1_H3_self_employed_debt_advice_answers]
    factory :S1_H4_urgent_pension_advice, traits: [:country, :S1_H4_pension_advice_answers]

    # Any of these Q6A1-A6, Q7A1-A9, Q9A1-A11 BUT NOT IF HAVE SELECTED Q1A2 PLUS the regional variation
    trait :S1_H1_debt_advice_answers do
      q1 { answers_with_entropy('q1', ['a1'], [])  }
      q2 { answers_with_entropy('q2', ['a2'], nil)  }
      q3 { answers_with_entropy('q3', [], nil)  }
      q4 { answers_with_entropy('q4', [], nil)  }
      q5 { answers_with_entropy('q5', [], nil)  }
      q6 { answers_with_entropy('q6', ['a1', 'a2', 'a3', 'a4', 'a5', 'a6'], nil) }
      q7 { answers_with_entropy('q7', ['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9'], nil) }
      q8 { answers_with_entropy('q8', [], nil)  }
      q9 { answers_with_entropy('q9', ['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9', 'a10', 'a11'], nil)  }
      q11 { answers_with_entropy('q11', [], nil)  }
      q12 { answers_with_entropy('q12', [], nil)  }
      q13 { answers_with_entropy('q13', [], nil)  }
      q14 { answers_with_entropy('q14', [], nil)  }
    end

    trait :S1_H3_self_employed_debt_advice_answers do
      q1 { answers_with_entropy('q1', ['a2'], [])  }
      q2 { answers_with_entropy('q2', [], nil)  }
      q3 { answers_with_entropy('q3', ['a2'], [])  }
      q4 { answers_with_entropy('q4', ['a1'], [] )}
      q5 { answers_with_entropy('q5', [], nil ) }
      q6 { answers_with_entropy('q6', ['a4',  'a5', 'a6'], [])}
      q7 { answers_with_entropy('q7', ['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil)  }
      q11 { answers_with_entropy('q11', [], nil)  }
      q12 { answers_with_entropy('q12', [], nil)  }
      q13 { answers_with_entropy('q13', [], nil)  }
      q14 { answers_with_entropy('q14', [], nil)  }
    end

    trait :S1_H4_pension_advice_answers do
      q1 { answers_with_entropy('q1', [], nil)  }
      q2 { answers_with_entropy('q2', [], nil)  }
      q3 { answers_with_entropy('q3', [], nil)  }
      q4 { answers_with_entropy('q4', [], nil )}
      q5 { answers_with_entropy('q5', [], nil)  }
      q6 { answers_with_entropy('q6', [], nil)}
      q7 { answers_with_entropy('q7', [], nil )}
      q8 { answers_with_entropy('q8', [], nil)  }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil)  }
      q12 { answers_with_entropy('q12', ['a2'], nil)  }
      q13 { answers_with_entropy('q13', [], nil)  }
      q14 { answers_with_entropy('q14', [], nil)  }
    end

  end
end
