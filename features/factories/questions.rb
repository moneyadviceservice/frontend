include Symbols

#TODO consider moving these methods into a module if needed for other fixtures. 
#Also to prevent polution of the global namespace (though not sure that's important given the way Factorybot is coded)
def randomn_answers(answers, allow_empty)
  choice = answers.sample(rand(1..answers.length)) if  !allow_empty
  choice = answers.sample(rand(0..answers.length)) if  allow_empty
  choice
end


def answers_with_entropy(question_code, mandatory_set, optional_set)
  mandated = randomn_answers(mandatory_set, false) unless mandatory_set.empty?
  mandated = [] if mandatory_set.empty?
  #All questions can be randomnly spliced in if the optional set is not explicitly given
  optional = randomn_answers((1..QUESTIONS_HASH[question_code].length).to_a.map{|index| "a#{index}"}, true) if optional_set.nil?
  #If the optional set is given then we can only select randomnly from it
  optional = randomn_answers(optional_set, true) unless optional_set.nil?
  answers = mandated | optional
  answers = answers[0] if answers.length == 1
  Rails.logger.debug("------>mandated: #{mandated}, optional: #{optional}, answers: #{answers}")
  answers
end

FactoryBot.define do
  factory :questions, class: Questions do
    
    factory :answers_requiring_urgent_scotland_action, traits: [:scotland, :urgent_action]
    factory :answers_requiring_urgent_england_action, traits: [:england, :urgent_action]
    factory :answers_requiring_urgent_ni_action, traits: [:northern_ireland, :urgent_action]
    factory :answers_requiring_urgent_wales_action, traits: [:wales, :urgent_action]

    factory :answers_requiring_urgent_england_stepchange_action, traits: [:england, :urgent_stepchange_action]
    factory :answers_requiring_urgent_ni_stepchange_action, traits: [:northern_ireland, :urgent_stepchange_action]
    factory :answers_requiring_urgent_wales_stepchange_action, traits: [:wales, :urgent_stepchange_action]
    factory :answers_requiring_urgent_scotland_stepchange_action, traits: [:scotland, :urgent_stepchange_action]

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

    trait :urgent_action do
      q1 { answers_with_entropy('q1', [], nil)  }
      q2 { answers_with_entropy('q2', [], nil)  }
      q3 { answers_with_entropy('q3', [], nil)  }
      q4 { answers_with_entropy('q4', ['a1'], nil)  }
      q5 { answers_with_entropy('q5', [], nil)  }
      q6 { answers_with_entropy('q6', (4..6).to_a.map{ |index| "a#{index}"  }, nil) }
      q7 { answers_with_entropy('q7', (1..9).to_a.map{ |index| "a#{index}"  }, nil) }
      q8 { answers_with_entropy('q8', [], nil)  }
      q9 { answers_with_entropy('q9', [], nil)  }
      q10 { answers_with_entropy('q10', ['a3'], nil ) }
      q11 { answers_with_entropy('q11', [], nil)  }
      q12 { answers_with_entropy('q12', [], nil)  }
      q13 { answers_with_entropy('q13', [], nil)  }
      q14 { answers_with_entropy('q14', [], nil)  }
    end

    trait :urgent_stepchange_action do
      q1 { answers_with_entropy('q1', [], nil)  }
      q2 { answers_with_entropy('q2', [], nil)  }
      q3 { answers_with_entropy('q3', ['a1'], nil)  }
      q4 { answers_with_entropy('q4', ['a2', 'a3'], ['a4'] )}
      q5 { answers_with_entropy('q5', [], nil)  }
      q6 { answers_with_entropy('q6', ['a4', 'a5'], ["a1", "a2", "a3", "a4", "a5", "a7"])}
      q7 { answers_with_entropy('q7', [], ['a10'] )}
      q8 { answers_with_entropy('q8', [], nil)  }
      q9 { answers_with_entropy('q9', (1..11).to_a.map{ |index| "a#{index}"}, nil) }
      q10 { answers_with_entropy('q10', ['a1'], ['a2'] ) }
      q11 { answers_with_entropy('q11', [], nil)  }
      q12 { answers_with_entropy('q12', [], nil)  }
      q13 { answers_with_entropy('q13', [], nil)  }
      q14 { answers_with_entropy('q14', [], nil)  }
    end

  end
end
