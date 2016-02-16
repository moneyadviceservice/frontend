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

When(/^I visit a corporate page in "(.*?)"$/) do |language|
  locale = language_to_locale(language)
  corporate_page.load(locale: locale)
end

Then(/^I should not see the sticky footer on the corporate page$/) do
  expect(corporate_page).to have_no_sticky_newsletter
end

When(/^I visit a tools page in "(.*?)"$/) do |language|
  locale = language_to_locale(language)
  tools_page.load(locale: locale, id: 'budget-planner')
end

Then(/^I should not see the sticky footer on the tools page$/) do
  expect(tools_page).to have_no_sticky_newsletter
end

When(/^I visit a videos page in "(.*?)"$/) do |language|
  step "I view a video in #{language}"
end

Then(/^I should not see the sticky footer on the videos page$/) do
  expect(video_page).to have_no_sticky_newsletter
end

When(/^I visit a corporate_categories page$/) do
  corporate_categories_page.load(locale: 'en', id: 'media-centre')
end

Then(/^I should not see the sticky footer on the corporate_categories page$/) do
  expect(corporate_categories_page).to have_no_sticky_newsletter
end

When(/^I visit a sitemap page in "(.*?)"$/) do |language|
  locale = language_to_locale(language)
  sitemap_page.load(locale: locale)
end

Then(/^I should not see the sticky footer on the sitemap page$/) do
  expect(sitemap_page).to have_no_sticky_newsletter
end

When(/^I visit an user account page in "(.*?)"$/) do |language|
  locale = language_to_locale(language)

  sign_up_page.load(locale: locale)
  sign_in_page.load(locale: locale)
  profile_page.load(locale: locale)
end

Then(/^I should not see the sticky footer on the user account page$/) do
  expect(sign_up_page).to have_no_sticky_newsletter
  expect(sign_in_page).to have_no_sticky_newsletter
  expect(profile_page).to have_no_sticky_newsletter
end

When(/^I visit an articles page in "(.*?)"$/) do |language|
  step "I view an article in #{language}"
end

Then(/^I should not see the sticky footer on the article page$/) do
  expect(article_page).to have_sticky_newsletter
end
