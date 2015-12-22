When(/^I visit an article page before "(.*?)"$/) do |go_live_date|
  before_go_live_date = Chronic.parse(go_live_date) - 2.days

  Timecop.freeze(before_go_live_date) do
    step 'I view an article in English'
  end
end

When(/^I visit an article page on an active campaign "(.*?)"$/) do |date|
  active_campaign_date = Chronic.parse(date)
  Timecop.freeze(active_campaign_date) do
    step 'I view an article in English'
  end
end

Then(/^I should not see the Survive January campaign banner$/) do
  expect(article_page).to have_no_survive_january_promo
end

Then(/^I should see the Survive January campaign banner$/) do
  expect(article_page).to have_survive_january_promo
end
