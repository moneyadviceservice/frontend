When(/^I view my profile page$/) do
  profile_page.load(locale: 'en')
end

Then(/^I see my name$/) do
  expect(profile_page.heading.text).to include(User.first.first_name)
end

Then(/^I see my goal and goal date is blank$/) do
  expect(profile_page.goal_text.value).to eql('')
  expect(profile_page.goal_date.value).to eql('')
end

When(/^I set a new goal and goal date$/) do
  profile_page.goal_text.set 'reduce unnecessary expense items'
  profile_page.goal_date.set 'this time next year'
  profile_page.goal_save.click
end

And(/^I see my goal and goal date$/) do
  expect(profile_page.goal_text.value).to eql(User.first.goal_text)
  expect(profile_page.goal_date.value).to eql(User.first.goal_date)
end
