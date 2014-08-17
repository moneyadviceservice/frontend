Given(/^chat is online$/) do
  Timecop.travel(Chronic.parse('Tuesday 2pm'))

  step 'I visit the website'
end

Given(/^chat will be next online later today$/) do
  Timecop.travel(Chronic.parse('Tuesday 5am'))

  step 'I visit the website'
end

Given(/^chat will be next online tomorrow$/) do
  Timecop.travel(Chronic.parse('Tuesday 11pm'))

  step 'I visit the website'
end

Given(/^an advisor is available$/) do
  if Capybara.current_driver == Capybara.javascript_driver
    page.driver.execute_script 'sWOImage.width = 10; sWOImageLoaded();'
  end
end

Given(/^all advisors are busy$/) do
  if Capybara.current_driver == Capybara.javascript_driver
    page.driver.execute_script 'sWOImage.width = 1; sWOImageLoaded();'
  end
end

When(/^I visit the website in Welsh$/) do
  home_page.load(locale: :cy)
end

Then(/^I should be able to start a chat with an advisor$/) do
  expect(home_page.chat.button).
    to have_content(I18n.t('contact_panels.chat.available.call_to_action'))

  expect(home_page.chat.description).
    to have_content(I18n.t('contact_panels.chat.available.description'))
end

Then(/^I should not be able to start a chat with an advisor$/) do
  expect(home_page.chat.button['class']).to include('is-disabled')
end

Then(/^I should see a message informing me that I need JavaScript in order chat with an advisor$/) do
  expect(home_page.chat).to have_javascript_warning
end

Then(/^I should see a message informing me that chat is currently busy$/) do
  expect(home_page.chat.button).
    to have_content(I18n.t('contact_panels.chat.busy.call_to_action'))

  expect(home_page.chat.description).
    to have_content(I18n.t('contact_panels.chat.busy.description'))
end

Then(/^I should see a message informing me that chat will be online between today's opening hours$/) do
  expect(home_page.chat.description).
    to have_content(I18n.t('contact_panels.chat.offline.description'))
end

Then(/^I should see a message informing me that chat will be online tomorrow with tomorrow's opening hours$/) do
  expect(home_page.chat.description).
    to have_content(I18n.t('contact_panels.chat.offline.description'))
end

Then(/^I should see a message informing me that chat is only available in English$/) do
  expect(home_page.chat).to have_smallprint
end
