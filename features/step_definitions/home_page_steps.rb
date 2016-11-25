include ActionView::Helpers::SanitizeHelper

Given(/^I (?:am on|visit) the home page$/) do
  home_page.load
end

Given(/^cms home page enabled$/) do
  Core::Registry::Repository[:home_page] =
    Core::Repository::VCR.new(Core::Repository::HomePages::CMS.new)
end

Given(/^I view the home page in (.*)$/) do |language|
  locale = language_to_locale(language)

  home_page.load(locale: locale)
end

When(/^I choose to view the Welsh version$/) do
  expect(home_page.footer_secondary.welsh_link[:lang])
    .to eq('cy')

  home_page.footer_secondary.welsh_link.click
end

Then(/^I should see the Money Advice Service brand identity$/) do
  expect(home_page.header.logo).to be_visible
end

Then(/^I should see a message(?: in my language)? to gain my trust?$/) do
  expected_en = "Free and impartial money advice, set up by government"
  expected_cy = "wufhwehfu"

  expect(home_page.trust_banner.heading)
    .to have_content(eval("expected_#{I18n.locale}"))
end

Then(/^I should see directory items$/) do
  expect(home_page).to have_directory_items
end

Then(/^I should see promoted content$/) do
  expected_text = ["Countdown to Christmas starts now!", "Can you guess the cost of emergencies?", "Give yourself a financial workout", "Prepare for the new arrival"]
  actual_text   = home_page.promos.map { |item| item.heading.text }

  expect(actual_text).to eq(expected_text)

  expected_text = ["Estimate the cost of buying a house and moving", "Universal Credit explained"]
  actual_text = home_page.promos_no_image.map { |item| item.heading.text }

  expect(actual_text).to eq(expected_text)
end

Then(/^I should see stripe banner$/) do
  expected_url = 'https://www.moneyadviceservice.org.uk/en/tools/debt-advice-locator'
  actual_url  = home_page.stripe_banner.link[:href]
  expect(actual_url).to eq(expected_url)

  expected_text = 'Worried about debt? Find out where to get free, confidential help now'
  actual_text  = home_page.stripe_banner.link.text
  expect(actual_text).to eq(expected_text)
end

Then(/^I should see information about contacting the Money Advice Service call centre$/) do
  expect(home_page.contact_heading).to have_content(I18n.t('contact_panels.call_us.title'))

  expect(home_page.contact_introduction)
    .to have_content(strip_tags(I18n.t('contact_panels.call_us.description')))

  expect(home_page.contact_number)
    .to have_content(I18n.t('contact.telephone_number'))
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

  expect(facebook_link[:href])
    .to eq('https://www.facebook.com/MoneyAdviceService?ref=mas')

  expect(twitter_link[:href])
    .to eq('https://twitter.com/YourMoneyAdvice')

  expect(youtube_link[:href])
    .to eq('https://www.youtube.com/user/MoneyAdviceService')
end

Then(/^the home page should have a canonical tag for that language version$/) do
  expected_href = root_url(locale: current_locale)

  expect { home_page.canonical_tag[:href] }.to become(expected_href)
end

Then(/^the home page should have alternate tags for the supported locales$/) do
  expected_hreflangs = ['en-GB', 'cy-GB']
  expected_hrefs = []
  I18n.available_locales.each { |locale| expected_hrefs << root_url(locale: locale) }

  home_page.alternate_tags.each do |alternate_tag|
    expect(expected_hreflangs).to include(alternate_tag[:hreflang])
    expect(expected_hrefs).to include(alternate_tag[:href])
  end
end

Then(/^the home page should have a description tag for that language version$/) do
  expect { home_page.description[:content] }.to become(I18n.t('home.show.description').strip)
end
