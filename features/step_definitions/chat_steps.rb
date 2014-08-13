Given(/^chat is online$/) do
  pending
end

Given(/^chat is offline$/) do
  pending
end

Given(/^an advisor is available$/) do
  pending
end

Given(/^all advisors are busy$/) do
  pending
end

When(/^I visit the website in Welsh$/) do
  home_page.load(locale: :cy)
end

When(/^chat will be next online later today$/) do
  pending
end

When(/^chat will be next online tomorrow$/) do
  pending
end

Then(/^I should be able to start a chat with an advisor$/) do
  pending
end

Then(/^I should not be able to start a chat with an advisor$/) do
  expect(home_page.chat.button).to be_disabled
end

Then(/^I should see a message informing me that I need JavaScript in order chat with an advisor$/) do
  pending
end

Then(/^I should see a message informing me that chat is currently busy$/) do
  pending
end

Then(/^I should see a message informing me that chat will be online between today's opening hours$/) do
  pending
end

Then(/^I should see a message informing me that chat will be online tomorrow with tomorrow's opening hours$/) do
  pending
end

Then(/^I should see a message informing me that chat is only available in English$/) do
  expect(home_page.chat).to have_welsh_warning
end
