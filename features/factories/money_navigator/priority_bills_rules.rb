require_relative 'rules_factory_common'

FactoryBot.define do
  factory :priority_bills, parent: :answers do

    factory :S6_H1_missed_payment_low, traits: [:country, :S6_H1_missed_payment_low_answers]

    factory :S6_H2_council_tax_severe, traits: [:country, :S6_H2_tax_severe_answers]
    factory :S6_H2_domestic_rates_severe, traits: [:country, :S6_H2_tax_severe_answers]
    factory :S6_H2_council_tax_temp_worried, traits: [:country, :S6_H2_tax_temp_worried_answers]
    factory :S6_H2_domestic_rates_temp_worried, traits: [:country, :S6_H2_tax_temp_worried_answers]
    factory :S6_H2_council_tax_temp_normal, traits: [:country, :S6_H2_tax_temp_normal_answers]
    factory :S6_H2_domestic_rates_temp_normal, traits: [:country, :S6_H2_tax_temp_normal_answers]
    factory :S6_H2_council_tax_no_change, traits: [:country, :S6_H2_tax_no_change_answers]
    factory :S6_H2_domestic_rates_no_change, traits: [:country, :S6_H2_tax_no_change_answers]

    factory :S6_H3_gas_electricity_severe, traits: [:country, :S6_H3_gas_electricity_severe_answers]
    factory :S6_H3_gas_electricity_temp_worried, traits: [:country, :S6_H3_gas_electricity_temp_worried_answers]
    factory :S6_H3_gas_electricity_temp_normal, traits: [:country, :S6_H3_gas_electricity_temp_normal_answers]
    factory :S6_H3_gas_electricity_no_change, traits: [:country, :S6_H3_gas_electricity_no_change_answers]

    factory :S6_H4_dmp_hmrc_severe, traits: [:country, :S6_H4_dmp_hmrc_severe_answers]
    factory :S6_H4_dmp_hmrc_temp_worried, traits: [:country, :S6_H4_dmp_hmrc_temp_worried_answers]
    factory :S6_H4_dmp_hmrc_temp_normal, traits: [:country, :S6_H4_dmp_hmrc_temp_normal_answers]
    factory :S6_H4_dmp_hmrc_no_change, traits: [:country, :S6_H4_dmp_hmrc_no_change_answers]

    factory :S6_H5_tv_licence_severe, traits: [:country, :S6_H5_tv_licence_severe_answers]
    factory :S6_H5_tv_licence_temp_worried, traits: [:country, :S6_H5_tv_licence_temp_worried_answers]
    factory :S6_H5_tv_licence_temp_normal, traits: [:country, :S6_H5_tv_licence_temp_normal_answers]
    factory :S6_H5_tv_licence_no_change, traits: [:country, :S6_H5_tv_licence_no_change_answers]

    factory :S6_H6_income_tax_severe, traits: [:country, :S6_H6_income_tax_severe_answers]
    factory :S6_H6_income_tax_temp_worried, traits: [:country, :S6_H6_income_tax_temp_worried_answers]
    factory :S6_H6_income_tax_temp_normal, traits: [:country, :S6_H6_income_tax_temp_normal_answers]
    factory :S6_H6_income_tax_no_change, traits: [:country, :S6_H6_income_tax_no_change_answers]

    factory :S6_H7_child_maintenance_severe, traits: [:country, :S6_H7_child_maintenance_severe_answers]
    factory :S6_H7_child_maintenance_temp_worried, traits: [:country, :S6_H7_child_maintenance_temp_worried_answers]
    factory :S6_H7_child_maintenance_temp_normal, traits: [:country, :S6_H7_child_maintenance_temp_normal_answers]
    factory :S6_H7_child_maintenance_no_change, traits: [:country, :S6_H7_child_maintenance_no_change_answers]

    factory :S6_H8_court_fines_severe, traits: [:country, :S6_H8_court_fines_severe_answers]
    factory :S6_H8_court_fines_temp_worried, traits: [:country, :S6_H8_court_fines_temp_worried_answers]
    factory :S6_H8_court_fines_temp_normal, traits: [:country, :S6_H8_court_fines_temp_normal_answers]
    factory :S6_H8_court_fines_temp_normal_ni, traits: [:country, :S6_H8_court_fines_temp_normal_ni_answers]
    factory :S6_H8_court_fines_temp_normal_scotland, traits: [:country, :S6_H8_court_fines_temp_normal_scotland_answers]
    factory :S6_H8_court_fines_no_change, traits: [:country, :S6_H8_court_fines_no_change_answers]

    factory :S6_H9_hire_purchase_severe, traits: [:country, :S6_H9_hire_purchase_severe_answers]
    factory :S6_H9_hire_purchase_temp_worried, traits: [:country, :S6_H9_hire_purchase_temp_worried_answers]
    factory :S6_H9_hire_purchase_temp_normal, traits: [:country, :S6_H9_hire_purchase_temp_normal_answers]
    factory :S6_H9_hire_purchase_no_change, traits: [:country, :S6_H9_hire_purchase_no_change_answers]

    factory :S6_H10_car_park_severe, traits: [:country, :S6_H10_car_park_severe_answers]
    factory :S6_H10_car_park_temp_worried, traits: [:country, :S6_H10_car_park_temp_worried_answers]
    factory :S6_H10_car_park_temp_normal, traits: [:country, :S6_H10_car_park_temp_normal_answers]
    factory :S6_H10_car_park_temp_normal_ni, traits: [:country, :S6_H10_car_park_temp_normal_ni_answers]
    factory :S6_H10_car_park_temp_normal_scotland, traits: [:country, :S6_H10_car_park_temp_normal_scotland_answers]
    factory :S6_H10_car_park_no_change, traits: [:country, :S6_H10_car_park_no_change_answers]

    trait :S6_H1_missed_payment_low_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', [], nil) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H2_tax_severe_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a1'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a1'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H2_tax_temp_worried_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a2'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a1'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H2_tax_temp_normal_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a3'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a1'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H2_tax_no_change_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a4'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a1'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H3_gas_electricity_severe_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a1'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a2'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H3_gas_electricity_temp_worried_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a2'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a2'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H3_gas_electricity_temp_normal_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a3'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a2'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H3_gas_electricity_no_change_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a4'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a2'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H4_dmp_hmrc_severe_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a1'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a3'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H4_dmp_hmrc_temp_worried_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a2'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a3'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H4_dmp_hmrc_temp_normal_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a3'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a3'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H4_dmp_hmrc_no_change_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a4'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a3'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H5_tv_licence_severe_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a1'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a4'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H5_tv_licence_temp_worried_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a2'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a4'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H5_tv_licence_temp_normal_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a3'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a4'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H5_tv_licence_no_change_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a4'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a4'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end


    trait :S6_H6_income_tax_severe_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a1'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a5'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H6_income_tax_temp_worried_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a2'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a5'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H6_income_tax_temp_normal_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a3'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a5'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H6_income_tax_no_change_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a4'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a5'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H7_child_maintenance_severe_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a1'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a6'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H7_child_maintenance_temp_worried_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a2'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a6'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H7_child_maintenance_temp_normal_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a3'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a6'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H7_child_maintenance_no_change_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a4'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a6'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H8_court_fines_severe_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a1'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a7'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H8_court_fines_temp_worried_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a2'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a7'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H8_court_fines_temp_normal_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a3'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a7'], []) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H8_court_fines_temp_normal_ni_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a3'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a7'], []) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H8_court_fines_temp_normal_scotland_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a3'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a7'], []) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H8_court_fines_no_change_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a4'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a7'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H9_hire_purchase_severe_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a1'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a8'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H9_hire_purchase_temp_worried_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a2'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a8'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H9_hire_purchase_temp_normal_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a3'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a8'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H9_hire_purchase_no_change_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a4'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a8'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H10_car_park_severe_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a1'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a9'], []) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H10_car_park_temp_worried_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a2'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a9'], []) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H10_car_park_temp_normal_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a3'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a9'], nil) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H10_car_park_temp_normal_ni_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a3'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a9'], []) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H10_car_park_temp_normal_scotland_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a3'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a9'], []) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end

    trait :S6_H10_car_park_no_change_answers do
      q1 { answers_with_entropy('q1', [], nil) }
      q2 { answers_with_entropy('q2', [], nil) }
      q3 { answers_with_entropy('q3', [], nil) }
      q4 { answers_with_entropy('q4', ['a4'], []) }
      q5 { answers_with_entropy('q5', [], nil) }
      q6 { answers_with_entropy('q6', [], nil) }
      q7 { answers_with_entropy('q7', ['a9'],[] ) }
      q8 { answers_with_entropy('q8', [], nil) }
      q9 { answers_with_entropy('q9', [], nil) }
      q11 { answers_with_entropy('q11', [], nil) }
      q12 { answers_with_entropy('q12', [], nil) }
      q13 { answers_with_entropy('q13', [], nil) }
      q14 { answers_with_entropy('q14', [], nil) }
    end
  end
end
