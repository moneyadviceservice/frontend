When(/^I view my profile page$/) do
  profile_page.load(locale: 'en')
end

Then(/^I see my name$/) do
  expect(profile_page.heading.text).to include(User.all.first.first_name)
end

Then(/^I see my goal and goal date is blank$/) do
  expect(profile_page.goal_text.value).to eql('')
  expect(profile_page.goal_date.value).to eql('')
end

end
