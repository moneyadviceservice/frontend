Given(/^I am on the home page$/) do
  home_page.load
end

Given(/^I view the home page in (.*)$/) do |language|
  locale = language_to_locale(language)

  home_page.load(locale: locale)
end

When(/^I visit the home page$/) do
  home_page.load
end

When(/^I choose to view the Welsh version$/) do
  expect(home_page.footer_site_links.welsh_link[:lang]).
    to eq('cy')

  home_page.footer_site_links.welsh_link.click
end

When(/^I search for something relevant$/) do
  home_page.search_box.input.set 'health'
  VCR.use_cassette("search_relevant") do
    home_page.search_box.submit.click
  end
end

When(/^I search for something irrelevant$/) do
  home_page.search_box.input.set 'cats'

  VCR.use_cassette("search_irrelevant") do
    home_page.search_box.submit.click
  end
end

When(/^I submit a search with no query$/) do
  home_page.search_box.input.set ''
  home_page.search_box.submit.click
end

Then(/^I should see the Money Advice Service brand identity$/) do
  expect(home_page.header.logo).to be_visible
  expect(home_page.footer_social_links.logo).to be_visible
end

Then(/^I should see an introduction(?: in my language)?$/) do
  expect(home_page.heading).
    to have_content(strip_tags(I18n.t('home.show.heading_html')))

  expect(home_page.summary_list).
    to have_content(strip_tags(I18n.t('home.show.summary_list_html')))

  expect(home_page.introduction_text).
    to have_content(strip_tags(I18n.t('home.show.introduction_text_html')))
end

Then(/^I should be taken to that social media profile$/) do
  expect(current_url).to eql('https://www.youtube.com/user/MoneyAdviceService')
end


Then(/^I should be see links to MAS social media profiles$/) do
  facebook_link = home_page.footer_social_links.facebook_link
  twitter_link  = home_page.footer_social_links.twitter_link
  youtube_link  = home_page.footer_social_links.youtube_link

  expect(facebook_link[:lang]).to eq('en')
  expect(twitter_link[:lang]).to eq('en')
  expect(youtube_link[:lang]).to eq('en')

  expect(facebook_link[:href]).
    to eq('https://www.facebook.com/MoneyAdviceService?ref=mas')

  expect(twitter_link[:href]).
    to eq('http://twitter.com/YourMoneyAdvice')

  expect(youtube_link[:href]).
    to eq('https://www.youtube.com/user/MoneyAdviceService')
end

Then(/^I should see the search box$/) do
  home_page.should have_search_box
end

Then(/^the home page should have a canonical tag for that language version$/) do
  expected_href = root_url(locale: current_locale)

  expect { home_page.canonical_tag[:href] }.to become(expected_href)
end


