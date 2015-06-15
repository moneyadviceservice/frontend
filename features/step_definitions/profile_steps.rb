require 'cucumber/rspec/doubles'

When(/^I view my profile page$/) do
  profile_page.load(locale: 'en')
end

Given(/^I am signed in with warden$/) do
  @user = create(:user)
  login_as(@user, scope: :user)
end

Then(/^I see my name$/) do
  expect(profile_page.heading.text).to include(User.first.first_name)
end

And(/^I have no saved data for any tools$/) do
  allow(@user).to receive(:data_for?).and_return(false)
end

Then(/^I see a message prompting me to try a tool$/) do
  expect(profile_page.saved_tools_message.text).to include(I18n.t('saved_tools.no_data_message'))
end

And(/^I have saved data for the "([^"]*)" tool$/) do |tool_name|
  allow(@user).to receive(:data_for?) do |argument|
    argument == tool_name.to_sym
  end
end

Then(/^I see the "([^"]*)" tool listed under saved tools$/) do |tool_title|
  expect(profile_page.saved_tools_list.text).to include(tool_title)
end
