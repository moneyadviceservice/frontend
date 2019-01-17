Then(/^I should see a message informing me that WhatsApp chat is only available in English$/) do
  expect(home_page.whatsapp).to have_smallprint
end

Then(/^I should see an unavailable message$/) do
  expect(home_page.whatsapp.unavailable).to have_content(I18n.t('contact_panels.chat.unavailable.call_to_action'))
end

Then(/^I should see a whats app link$/) do
  expect(home_page.whatsapp.link).to be_truthy
end

When(/^I visit the website on a desktop device$/) do
  page.driver.resize_window 1200, 768
end

Then(/^I should not see the WhatsApp chat$/) do
  expect(page).to_not have_css('.contact-panel__whatsapp')
end


