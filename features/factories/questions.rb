FactoryBot.define do
  factory :questions, class: Questions do
    
    factory :answers_requiring_urgent_scotland_action, traits: [:scotland_urgent_action]
    factory :answers_requiring_urgent_england_action, traits: [:england_urgent_action]

    trait :scotland_urgent_action do
      q0 { 'a3' }
      q1 { 'a1' }
      q2 { 'a1' }
      q3 { 'a1' }
      q4 { 'a1' }
      q5 { 'a1' }
      q6 { ['a4', 'a5', 'a6'] }
      q7 { ['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9'] }
      q8 { ['a1'] }
      q9 { ['a1'] }
      q10 { 'a3' }
      q11 { 'a1' }
      q12 { 'a1' }
      q13 { ['a1'] }
      q14 { 'a1' }
    end
    trait :england_urgent_action do
      q0 { 'a1' }
      q1 { 'a1' }
      q2 { 'a2' }
      q3 { 'a1' }
      q4 { 'a1' }
      q5 { 'a1' }
      q6 { ['a4', 'a5', 'a6'] }
      q7 { ['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9'] }
      q8 { ['a1', 'a2'] }
      q9 { ['a1'] }
      q10 { 'a3' }
      q11 { 'a1' }
      q12 { ['a1', 'a3'] }
      q13 { 'a1' }
      q14 { 'a1' }
    end
  end
end
