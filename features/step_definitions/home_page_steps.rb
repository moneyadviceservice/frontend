Given(/^I am on the home page$/) do
  home_page.load
end

When(/^I visit the home page$/) do
  home_page.load
end

When(/^I choose to view the Welsh version$/) do
  home_page.welsh_link.click
end

Then(/^I should see the Money Advice Service brand identity$/) do
  expect(home_page.header.logo).to be_visible
  expect(home_page.footer.logo).to be_visible
end

Then(/^I should see an introduction(?: in my language)?$/) do
  expect(home_page.heading).
    to have_content(I18n.t('home.show.heading'))

  expect(home_page.summary_list).
    to have_content(strip_tags(I18n.t('home.show.summary_list_html')))

  expect(home_page.introduction_text).
    to have_content(strip_tags(I18n.t('home.show.introduction_text_html')))
end
