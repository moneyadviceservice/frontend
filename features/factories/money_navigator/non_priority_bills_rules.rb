require_relative 'rules_factory_common'

FactoryBot.define do
  factory :non_priority_bills, parent: :answers do

    factory :S7_H1_personal_loan_severe, traits: [:country, :S7_H1_personal_loan_severe_answers]
    factory :S7_H1_personal_loan_temp_worried, traits: [:country, :S7_H1_personal_loan_temp_worried_answers]
    factory :S7_H1_personal_loan_temp_normal, traits: [:country, :S7_H1_personal_loan_temp_normal_answers]
    factory :S7_H1_personal_loan_no_change, traits: [:country, :S7_H1_personal_loan_no_change_answers]

    factory :S7_H2_water_severe, traits: [:country, :S7_H2_water_severe_answers]
    factory :S7_H2_water_temp_worried, traits: [:country, :S7_H2_water_temp_worried_answers]
    factory :S7_H2_water_temp_normal, traits: [:country, :S7_H2_water_temp_normal_answers]
    factory :S7_H2_water_no_change, traits: [:country, :S7_H2_water_no_change_answers]

    factory :S7_H3_mobile_tv_broadband_severe, traits: [:country, :S7_H3_mobile_tv_broadband_severe_answers]
    factory :S7_H3_mobile_tv_broadband_temp_worried, traits: [:country, :S7_H3_mobile_tv_broadband_temp_worried_answers]
    factory :S7_H3_mobile_tv_broadband_temp_normal, traits: [:country, :S7_H3_mobile_tv_broadband_temp_normal_answers]
    factory :S7_H3_mobile_tv_broadband_no_change, traits: [:country, :S7_H3_mobile_tv_broadband_no_change_answers]

    factory :S7_H4_credit_card_severe, traits: [:country, :S7_H4_credit_card_severe_answers]
    factory :S7_H4_credit_card_temp_worried, traits: [:country, :S7_H4_credit_card_temp_worried_answers]
    factory :S7_H4_credit_card_temp_normal, traits: [:country, :S7_H4_credit_card_temp_normal_answers]
    factory :S7_H4_credit_card_no_change, traits: [:country, :S7_H4_credit_card_no_change_answers]

    factory :S7_H5_store_card_severe, traits: [:country, :S7_H5_store_card_severe_answers]
    factory :S7_H5_store_card_temp_worried, traits: [:country, :S7_H5_store_card_temp_worried_answers]
    factory :S7_H5_store_card_temp_normal, traits: [:country, :S7_H5_store_card_temp_normal_answers]
    factory :S7_H5_store_card_no_change, traits: [:country, :S7_H5_store_card_no_change_answers]

    factory :S7_H6_car_finance_severe, traits: [:country, :S7_H6_car_finance_severe_answers]
    factory :S7_H6_car_finance_temp_worried, traits: [:country, :S7_H6_car_finance_temp_worried_answers]
    factory :S7_H6_car_finance_temp_normal, traits: [:country, :S7_H6_car_finance_temp_normal_answers]
    factory :S7_H6_car_finance_no_change, traits: [:country, :S7_H6_car_finance_no_change_answers]

    factory :S7_H7_buy_now_pay_later_severe, traits: [:country, :S7_H7_buy_now_pay_later_severe_answers]
    factory :S7_H7_buy_now_pay_later_temp_worried, traits: [:country, :S7_H7_buy_now_pay_later_temp_worried_answers]
    factory :S7_H7_buy_now_pay_later_temp_normal, traits: [:country, :S7_H7_buy_now_pay_later_temp_normal_answers]
    factory :S7_H7_buy_now_pay_later_no_change, traits: [:country, :S7_H7_buy_now_pay_later_no_change_answers]

    factory :S7_H8_rent_to_own_severe, traits: [:country, :S7_H8_rent_to_own_severe_answers]
    factory :S7_H8_rent_to_own_temp_worried, traits: [:country, :S7_H8_rent_to_own_temp_worried_answers]
    factory :S7_H8_rent_to_own_temp_normal, traits: [:country, :S7_H8_rent_to_own_temp_normal_answers]
    factory :S7_H8_rent_to_own_no_change, traits: [:country, :S7_H8_rent_to_own_no_change_answers]

    factory :S7_H9_payday_loan_severe, traits: [:country, :S7_H9_payday_loan_severe_answers]
    factory :S7_H9_payday_loan_temp_worried, traits: [:country, :S7_H9_payday_loan_temp_worried_answers]
    factory :S7_H9_payday_loan_temp_normal, traits: [:country, :S7_H9_payday_loan_temp_normal_answers]
    factory :S7_H9_payday_loan_no_change, traits: [:country, :S7_H9_payday_loan_no_change_answers]

    factory :S7_H10_pawnbroker_severe, traits: [:country, :S7_H10_pawnbroker_severe_answers]
    factory :S7_H10_pawnbroker_temp_worried, traits: [:country, :S7_H10_pawnbroker_temp_worried_answers]
    factory :S7_H10_pawnbroker_temp_normal, traits: [:country, :S7_H10_pawnbroker_temp_normal_answers]
    factory :S7_H10_pawnbroker_no_change, traits: [:country, :S7_H10_pawnbroker_no_change_answers]

    factory :S7_H11_friends_family_severe, traits: [:country, :S7_H11_friends_family_severe_answers]
    factory :S7_H11_friends_family_temp_worried, traits: [:country, :S7_H11_friends_family_temp_worried_answers]
    factory :S7_H11_friends_family_temp_normal, traits: [:country, :S7_H11_friends_family_temp_normal_answers]
    factory :S7_H11_friends_family_no_change, traits: [:country, :S7_H11_friends_family_no_change_answers]

    trait :S7_H1_personal_loan_severe_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a1'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', ['a1', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9', 'a10'], []) }
      q9 { answers_with_entropy('q9', ['a1'], []) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H1_personal_loan_temp_worried_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a2'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', ['a1', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9', 'a10'], []) }
      q9 { answers_with_entropy('q9', ['a1'], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H1_personal_loan_temp_normal_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a3'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', ['a1', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9', 'a10'], []) }
      q9 { answers_with_entropy('q9', ['a1'], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H1_personal_loan_no_change_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a4'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', ['a1', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9', 'a10'], []) }
      q9 { answers_with_entropy('q9', ['a1'], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H2_water_severe_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a1'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', ['a2'], []) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H2_water_temp_worried_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a2'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', ['a2'], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H2_water_temp_normal_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a3'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', ['a2'], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H2_water_no_change_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a4'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', ['a2'], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H3_mobile_tv_broadband_severe_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a1'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', ['a3'], []) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H3_mobile_tv_broadband_temp_worried_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a2'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', ['a3'], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H3_mobile_tv_broadband_temp_normal_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a3'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', ['a3'], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H3_mobile_tv_broadband_no_change_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a4'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', ['a3'], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H4_credit_card_severe_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a1'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', ['a1', 'a2', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9', 'a10'], []) }
      q9 { answers_with_entropy('q9', ['a4'], []) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H4_credit_card_temp_worried_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a2'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', ['a1', 'a2', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9', 'a10'], []) }
      q9 { answers_with_entropy('q9', ['a4'], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H4_credit_card_temp_normal_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a3'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', ['a1', 'a2', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9', 'a10'], []) }
      q9 { answers_with_entropy('q9', ['a4'], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H4_credit_card_no_change_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a4'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', ['a1', 'a2', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9', 'a10'], []) }
      q9 { answers_with_entropy('q9', ['a4'], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H5_store_card_severe_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a1'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', ['a1', 'a2', 'a3', 'a5', 'a6', 'a7', 'a8', 'a9', 'a10'], []) }
      q9 { answers_with_entropy('q9', ['a5'], []) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H5_store_card_temp_worried_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a2'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', ['a1', 'a2', 'a3', 'a5', 'a6', 'a7', 'a8', 'a9', 'a10'], []) }
      q9 { answers_with_entropy('q9', ['a5'], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H5_store_card_temp_normal_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a3'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', ['a1', 'a2', 'a3', 'a5', 'a6', 'a7', 'a8', 'a9', 'a10'], []) }
      q9 { answers_with_entropy('q9', ['a5'], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H5_store_card_no_change_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a4'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', ['a1', 'a2', 'a3', 'a5', 'a6', 'a7', 'a8', 'a9', 'a10'], []) }
      q9 { answers_with_entropy('q9', ['a5'], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H6_car_finance_severe_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a1'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', ['a1', 'a2', 'a3', 'a4', 'a6', 'a7', 'a8', 'a9', 'a10'], []) }
      q9 { answers_with_entropy('q9', ['a6'], []) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H6_car_finance_temp_worried_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a2'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', ['a1', 'a2', 'a3', 'a4', 'a6', 'a7', 'a8', 'a9', 'a10'], []) }
      q9 { answers_with_entropy('q9', ['a6'], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H6_car_finance_temp_normal_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a3'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', ['a1', 'a2', 'a3', 'a4', 'a6', 'a7', 'a8', 'a9', 'a10'], []) }
      q9 { answers_with_entropy('q9', ['a6'], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H6_car_finance_no_change_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a4'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', ['a1', 'a2', 'a3', 'a4', 'a6', 'a7', 'a8', 'a9', 'a10'], []) }
      q9 { answers_with_entropy('q9', ['a6'], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H7_buy_now_pay_later_severe_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a1'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', ['a1', 'a2', 'a3', 'a4', 'a5', 'a7', 'a8', 'a9', 'a10'], []) }
      q9 { answers_with_entropy('q9', ['a7'], []) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H7_buy_now_pay_later_temp_worried_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a2'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', ['a1', 'a2', 'a3', 'a4', 'a5', 'a7', 'a8', 'a9', 'a10'], []) }
      q9 { answers_with_entropy('q9', ['a7'], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H7_buy_now_pay_later_temp_normal_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a3'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', ['a1', 'a2', 'a3', 'a4', 'a5', 'a7', 'a8', 'a9', 'a10'], []) }
      q9 { answers_with_entropy('q9', ['a7'], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H7_buy_now_pay_later_no_change_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a4'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', ['a1', 'a2', 'a3', 'a4', 'a5', 'a7', 'a8', 'a9', 'a10'], []) }
      q9 { answers_with_entropy('q9', ['a7'], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H8_rent_to_own_severe_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a1'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', ['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a8', 'a9', 'a10'], []) }
      q9 { answers_with_entropy('q9', ['a8'], []) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H8_rent_to_own_temp_worried_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a2'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', ['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a8', 'a9', 'a10'], []) }
      q9 { answers_with_entropy('q9', ['a8'], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H8_rent_to_own_temp_normal_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a3'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', ['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a8', 'a9', 'a10'], []) }
      q9 { answers_with_entropy('q9', ['a8'], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H8_rent_to_own_no_change_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a4'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', ['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a8', 'a9', 'a10'], []) }
      q9 { answers_with_entropy('q9', ['a8'], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H9_payday_loan_severe_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a1'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', ['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a9', 'a10'], []) }
      q9 { answers_with_entropy('q9', ['a9'], []) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H9_payday_loan_temp_worried_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a2'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', ['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a9', 'a10'], []) }
      q9 { answers_with_entropy('q9', ['a9'], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H9_payday_loan_temp_normal_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a3'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', ['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a9', 'a10'], []) }
      q9 { answers_with_entropy('q9', ['a9'], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H9_payday_loan_no_change_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a4'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', ['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a9', 'a10'], []) }
      q9 { answers_with_entropy('q9', ['a9'], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H10_pawnbroker_severe_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a1'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', ['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a10'], []) }
      q9 { answers_with_entropy('q9', ['a10'], []) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H10_pawnbroker_temp_worried_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a2'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', ['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a10'], []) }
      q9 { answers_with_entropy('q9', ['a10'], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H10_pawnbroker_temp_normal_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a3'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', ['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a10'], []) }
      q9 { answers_with_entropy('q9', ['a10'], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H10_pawnbroker_no_change_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a4'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', ['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a10'], []) }
      q9 { answers_with_entropy('q9', ['a10'], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H11_friends_family_severe_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a1'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', ['a11'], []) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H11_friends_family_temp_worried_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a2'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', ['a11'], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H11_friends_family_temp_normal_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a3'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', ['a11'], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S7_H11_friends_family_no_change_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a4'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', [], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', ['a11'], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end
  end
end
