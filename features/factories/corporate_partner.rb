FactoryGirl.define do
  factory :corporate_partner, class: CorporatePartner do
    name 'Tenacious Co'
    sequence(:email) { |i| "fakeorg#{i}@example.com" }
    tool_name 'Sample Tool'
    tool_language 'en'
    tool_width_unit 'px'
    tool_width 500
  end
end
