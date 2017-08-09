When(/^I visit the conventional robots link$/) do
  visit 'robots.txt'
end

Then(/^I should see that Atomz is blocked from scrawling$/) do
  expect(page.text).to have_content 'User-Agent: Atomz Disallow: /'
end

Then(/^I should see that wpcc secret url is blocked from crawlers$/) do
  expect(page.text).to have_content('Disallow: /en/tools/wpcc')
  expect(page.text).to have_content('Disallow: /cy/tools/wpcc')
end
