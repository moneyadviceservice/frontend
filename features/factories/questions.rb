include Symbols

#TODO consider moving these methods into a module if needed for other fixtures.
#Also to prevent polution of the global namespace (though not sure that's important given the way Factorybot is coded)
def randomn_answers(answers, allow_empty)
  choice = answers.sample(rand(1..answers.length)) if  !allow_empty
  choice = answers.sample(rand(0..answers.length)) if  allow_empty
  choice
end


def answers_with_entropy(question_code, mandatory_set, optional_set)
  #A nill mandatory_set means nothing.
  #An empty mandatory set means nothing is mandatory (i.e. the question can be left unanswerd)
  mandated = randomn_answers(mandatory_set, false) unless mandatory_set.empty?
  mandated = [] if mandatory_set.empty?
  #All questions can be randomnly spliced in if the optional set is nil.
  #If it is an empty array then no other answers will be randomnly spliced in
  optional = randomn_answers((1..QUESTIONS_HASH[question_code].length).to_a.map{|index| "a#{index}"}, true) if optional_set.nil?
  #If the optional set is given then we can only select randomnly from it
  optional = randomn_answers(optional_set, true) unless optional_set.nil?
  answers = mandated | optional
  answers = answers[0] if answers.length == 1
  answers
end

FactoryBot.define do
  factory :questions, class: Questions do

    factory :urgent_action_scotland_debt_advice, traits: [:scotland, :urgent_debt_advice_action]
    factory :urgent_action_england_debt_advice, traits: [:england, :urgent_debt_advice_action]
    factory :urgent_action_ni_debt_advice, traits: [:northern_ireland, :urgent_debt_advice_action]
    factory :urgent_action_wales_debt_advice, traits: [:wales, :urgent_debt_advice_action]

    factory :urgent_action_england_stepchange_debt, traits: [:england, :urgent_stepchange_action]
    factory :urgent_action_ni_stepchange_debt, traits: [:northern_ireland, :urgent_stepchange_action]
    factory :urgent_action_wales_stepchange_debt, traits: [:wales, :urgent_stepchange_action]
    factory :urgent_action_scotland_stepchange_debt, traits: [:scotland, :urgent_stepchange_action]

    factory :urgent_action_england_self_employed_debt_advice, traits: [:england, :urgent_debtline_action]
    factory :urgent_action_ni_self_employed_debt_advice, traits: [:northern_ireland, :urgent_debtline_action]
    factory :urgent_action_wales_self_employed_debt_advice, traits: [:wales, :urgent_debtline_action]
    factory :urgent_action_scotland_self_employed_debt_advice, traits: [:scotland, :urgent_debtline_action]

    trait :scotland do
      q0 { 'a3' }
    end

    trait :england do
      q0 { 'a1' }
    end

    trait :wales do
      q0 { 'a4' }
    end

    trait :northern_ireland do
      q0 { 'a2' }
    end
    #TODO: Consider deriving these traits directly from the rules to minimise duplication
    trait :urgent_debt_advice_action do
      q1 { answers_with_entropy('q1', [], nil)  }
      q2 { answers_with_entropy('q2', [], nil)  }
      q3 { answers_with_entropy('q3', [], nil)  }
      q4 { answers_with_entropy('q4', ['a1'], nil)  }
      q5 { answers_with_entropy('q5', [], nil)  }
      q6 { answers_with_entropy('q6', ['a6'], nil) }
      q7 { answers_with_entropy('q7', ['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9'], nil) }
      q8 { answers_with_entropy('q8', [], nil)  }
      q9 { answers_with_entropy('q9', [], nil)  }
      q10 { answers_with_entropy('q10', ['a3'], nil ) }
      q11 { answers_with_entropy('q11', [], nil)  }
      q12 { answers_with_entropy('q12', [], nil)  }
      q13 { answers_with_entropy('q13', [], nil)  }
      q14 { answers_with_entropy('q14', [], nil)  }
    end

        #If any of these are selected Q3A1, Q4A2, Q4A3, Q6A4, Q6A5, Q8A1, Q8A3 
        #and NONE of these are selected Q2A4, Q5A1, Q5A2, Q5A3, Q8A1-A9  show this
    trait :urgent_stepchange_action do
      q1 { answers_with_entropy('q1', [], nil)  }
      q2 { answers_with_entropy('q2', [], [])  }
      q3 { answers_with_entropy('q3', ['a1'], nil)  }
      q4 { answers_with_entropy('q4', ['a2', 'a3'], ['a4'] )}
      q5 { answers_with_entropy('q5', [], nil)  }
      q6 { answers_with_entropy('q6', ['a4', 'a5'], ['a1', 'a2', 'a3', 'a4', 'a5', 'a7'])}
      q7 { answers_with_entropy('q7', [], ['a10'] )}
      q8 { answers_with_entropy('q8', ['a1', 'a2', 'a3'], nil)  }
      q9 { answers_with_entropy('q9', [], nil) }
      q10 { answers_with_entropy('q10', [], ['a2'] ) }
      q11 { answers_with_entropy('q11', [], nil)  }
      q12 { answers_with_entropy('q12', [], nil)  }
      q13 { answers_with_entropy('q13', [], nil)  }
      q14 { answers_with_entropy('q14', [], nil)  }
    end

    trait :urgent_debtline_action do
      q1 { answers_with_entropy('q1', ['a2'], nil)  }
      q2 { answers_with_entropy('q2', [], nil)  }
      q3 { answers_with_entropy('q3', ['a2'], nil)  }
      q4 { answers_with_entropy('q4', ['a1'], ['a4'] )}
      q5 { answers_with_entropy('q5', ['a3'], nil)  }
      q6 { answers_with_entropy('q6', ['a4', 'a6'], nil)}
      q7 { answers_with_entropy('q7', ['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9'], nil )}
      q8 { answers_with_entropy('q8', [], nil)  }
      q9 { answers_with_entropy('q9', [], nil) }
      q10 { answers_with_entropy('q10', ['a3'], nil) }
      q11 { answers_with_entropy('q11', [], nil)  }
      q12 { answers_with_entropy('q12', [], nil)  }
      q13 { answers_with_entropy('q13', [], nil)  }
      q14 { answers_with_entropy('q14', [], nil)  }
    end

  end
end
