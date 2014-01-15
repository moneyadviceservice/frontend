Given(/^I am on the home page$/) do
  home_page.load
end

When(/^I visit the home page$/) do
  home_page.load
end

When(/^I choose to view the Welsh version$/) do
  home_page.footer_site_links.welsh_link.click
end

Then(/^I should see the Money Advice Service brand identity$/) do
  expect(home_page.header.logo).to be_visible
  expect(home_page.footer_social_links.logo).to be_visible
end

Then(/^I should see an introduction(?: in my language)?$/) do
  expect(home_page.heading).
    to have_content(I18n.t('home.show.heading'))

  expect(home_page.summary_list).
    to have_content(strip_tags(I18n.t('home.show.summary_list_html')))

  expect(home_page.introduction_text).
    to have_content(strip_tags(I18n.t('home.show.introduction_text_html')))
end

Then(/^I should be taken to that social media profile$/) do
  expect(current_url).to eql('https://www.youtube.com/user/MoneyAdviceService')
end


Then(/^I should be see links to MAS social media profiles$/) do
  expect(home_page.footer_social_links.youtube_link[:href]).
    to eq('https://www.youtube.com/user/MoneyAdviceService')

  expect(home_page.footer_social_links.facebook_link[:href]).
    to eq('https://www.facebook.com/MoneyAdviceService?ref=mas')

  expect(home_page.footer_social_links.twitter_link[:href]).
    to eq('http://twitter.com/YourMoneyAdvice')
end
