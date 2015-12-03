When(/^I visit the homepage in "(.*?)"$/) do |language|
  locale = language_to_locale language
  home_page.load locale: locale
end

Then(/^I should not see the sticky footer on the home page$/) do
  expect(home_page).to have_no_sticky_newsletter
end

Then(/^I should not see the sticky footer on the category page$/) do
  expect(category_page).to have_no_sticky_newsletter
end

When(/^I visit a category page in "(.*?)"$/) do |language|
  step "I view a category containing child categories in #{language}"
end
