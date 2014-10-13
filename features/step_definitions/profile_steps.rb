When(/^I view my profile page$/) do
  profile_page.load(locale: 'en')
end

Then(/^I see my name$/) do
  expect(current_page.heading.text).to include(User.all.first.first_name)
end
