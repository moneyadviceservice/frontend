include Symbols

#TODO consider moving these methods into a module if needed for other fixtures. 
#Also to prevent polution of the global namespace (though not sure that's important given the way Factorybot is coded)
def randomn_answers(answers, allow_empty)
  choice = answers.sample(rand(1..answers.length)) if  !allow_empty
  choice = answers.sample(rand(0..answers.length)) if  allow_empty
  choice
end


def answers_with_entropy(question_code, mandatory_set)
  mandated = randomn_answers(mandatory_set, false) unless mandatory_set.empty?
  mandated = [] if mandatory_set.empty?
  optional = randomn_answers((0..QUESTIONS_HASH[question_code].length).to_a.map{|index| "a#{index}"}, true) 
  answers = mandated | optional
  answers = answers[0] if answers.length == 1
  answers
end

FactoryBot.define do
  factory :questions, class: Questions do
    
    factory :answers_requiring_urgent_scotland_action, traits: [:scotland_urgent_action]
    factory :answers_requiring_urgent_england_action, traits: [:england_urgent_action]
    factory :answers_requiring_urgent_northern_ireland_action, traits: [:northern_ireland_urgent_action]
    factory :answers_requiring_urgent_wales_action, traits: [:wales_urgent_action]

    trait :scotland_urgent_action do
      urgent_action
      q0 { 'a3' }
    end

    trait :england_urgent_action do
      urgent_action
      q0 { 'a1' }
    end
    
    trait :wales_urgent_action do
      urgent_action
      q0 { 'a4' }
    end

    trait :northern_ireland_urgent_action do
      urgent_action
      q0 { 'a2' }
    end

    trait :urgent_action do
      q1 { answers_with_entropy('q1', [])  }
      q2 { answers_with_entropy('q2', [])  }
      q3 { answers_with_entropy('q3', [])  }
      q4 { answers_with_entropy('q4', ['a1'])  }
      q5 { answers_with_entropy('q5', [])  }
      q6 { answers_with_entropy('q6', (4..6).to_a.map{ |index| "a#{index}"  }) }
      q7 { answers_with_entropy('q7', (1..9).to_a.map{ |index| "a#{index}"  }) }
      q8 { answers_with_entropy('q8', [])  }
      q9 { answers_with_entropy('q9', [])  }
      q10 { answers_with_entropy('q10', ['a3'] ) }
      q11 { answers_with_entropy('q11', [])  }
      q12 { answers_with_entropy('q12', [])  }
      q13 { answers_with_entropy('q13', [])  }
      q14 { answers_with_entropy('q14', [])  }
    end

  end
end
