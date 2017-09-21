When(/^I visit the conventional robots link$/) do
  visit 'robots.txt'
end

Then(/^I should see that Atomz is blocked from scrawling$/) do
  expect(page.text).to have_content 'User-Agent: Atomz Disallow: /'
end
