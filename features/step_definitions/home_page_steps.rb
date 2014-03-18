Given(/^I (?:am on|visit) the home page$/) do
  home_page.load
end

Given(/^I view the home page in (.*)$/) do |language|
  locale = language_to_locale(language)

  home_page.load(locale: locale)
end

When(/^I choose to view the Welsh version$/) do
  expect(home_page.footer_site_links.welsh_link[:lang]).
    to eq('cy')

  home_page.footer_site_links.welsh_link.click
end

Then(/^I should see the Money Advice Service brand identity$/) do
  expect(home_page.header.logo).to be_visible
  expect(home_page.footer_social_links.logo).to be_visible
end

Then(/^I should see a message(?: in my language)? to gain my trust?$/) do
  expect(home_page.strapline).
    to have_content(I18n.t('home.show.feature.strapline'))
end

Then(/^I should see featured topics$/) do
  expect(home_page.feature_list).
    to have_content(strip_tags(I18n.t('home.show.feature.list_html')))
end

Then(/^I should see information about contacting the Money Advice Service call centre$/) do
  expect(home_page.contact_heading).to have_content(I18n.t('home.show.contact.title'))

  expect(home_page.contact_introduction).
    to have_content(strip_tags(I18n.t('home.show.contact.introduction_html')))

  expect(home_page.contact_details).
    to have_content(strip_tags(I18n.t('home.show.contact.details_html')))
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

Then(/^the home page should have a canonical tag for that language version$/) do
  expected_href = root_url(locale: current_locale)

  expect { home_page.canonical_tag[:href] }.to become(expected_href)
end

Then(/^the home page should have an alternate tag for the (.*) version$/) do |language|
  locale        = language_to_locale(language)
  expected_href = root_url(locale: locale)

  expect { home_page.alternate_tag[:href] }.to become(expected_href)
  expect { home_page.alternate_tag[:hreflang] }.to become(locale)
end

When(/^I navigate from the home page to the partners page$/) do
  home_page.footer_site_links.partners_link.click
end

Then(/^the home page contains the cookie message$/) do
  expect(home_page).to have_cookie_message
end

When(/^the home page does not contain the cookie message$/) do
  expect(home_page).to have_no_cookie_message
end

Then(/^the home page contains an option to close the cookie message$/) do
  pending # express the regexp above with the code you wish you had
end
