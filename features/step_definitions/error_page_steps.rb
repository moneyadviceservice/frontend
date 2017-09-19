Given(/^that I visit the internal server error page in my "([^"]*)"$/) do |language|
  locale = language_to_locale(language)

  internal_server_error_page.load(locale: locale)
end

Given(/^that I visit a non\-existent page in my "([^"]*)"$/) do |language|
  locale = language_to_locale(language)

  page_not_found_page.load(locale: locale)
end

Then(/^I should see a friendly "([^"]*)"$/) do |error_message|
  expect(current_page).to have_content(error_message)
end
