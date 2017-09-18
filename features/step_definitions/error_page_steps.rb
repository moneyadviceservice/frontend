Given(/^that I visit the internal server error page in my "([^"]*)"$/) do |language|
  locale = language_to_locale(language)

  visit "/500?locale=#{locale}"
end

Given(/^that I visit a non\-existent page in my "([^"]*)"$/) do |language|
  locale = language_to_locale(language)

  visit "/404?locale=#{locale}"
end

Then(/^I should see a friendly "([^"]*)"$/) do |error_message|
  expect(page).to have_content(error_message)
end
