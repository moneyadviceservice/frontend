When(/^I view my profile page$/) do
  profile_page.load(locale: 'en')
end

Then(/^I see my name$/) do
  expect(profile_page.heading.text).to include(User.first.first_name)
end

Then(/^I see my goal and goal date is blank$/) do
  expect(profile_page.goal_statement.value).to be_empty
  expect(profile_page.goal_deadline.value).to be_empty
end

When(/^I set a new goal and goal date$/) do
  profile_page.goal_statement.set 'reduce unnecessary expense items'
  profile_page.goal_deadline.set 'this time next year'
  profile_page.goal_save.click
end

And(/^I see my goal and goal date$/) do
  expect(profile_page.goal_statement.value).to eql(User.first.goal_statement)
  expect(profile_page.goal_deadline.value).to eql(User.first.goal_deadline)
end
