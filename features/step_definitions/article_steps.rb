When(/^I view an article$/) do
  article_page.load(locale: I18n.locale, id: 'where-to-go-to-get-free-debt-advice')
end

Then(/^the article should be displayed$/) do
  expect(article_page.heading).to have_content('Where to go to get free debt advice')
end
