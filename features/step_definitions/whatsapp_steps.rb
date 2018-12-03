Then(/^I should be able to start a chat with an advisor via WhatsApp$/) do
  expect(home_page.whatsapp.button).to have_content(I18n.t('contact_panels.chat.available.call_to_action'))
  expect(home_page.whatsapp.description).to have_content(I18n.t('contact_panels.chat.available.description'))
end

Then(/^I should see a message informing me that I need JavaScript in order chat with an advisor via WhatsApp$/) do
  expect(home_page.whatsapp).to have_javascript_warning
end

Then(/^I should not be able to start a chat with an advisor via WhatsApp$/) do
  expect(home_page.whatsapp.button['class']).to include('is-disabled')
end

Then(/^I should see a message informing me that WhatsApp chat is currently busy$/) do
  expect(home_page.whatsapp.button).to have_content(I18n.t('contact_panels.chat.busy.call_to_action'))
  expect(home_page.whatsapp.description).to have_content(I18n.t('contact_panels.chat.busy.description'))
end

Then(/^I should see a message informing me that WhatsApp chat will be online between today's opening hours$/) do
  expect(home_page.whatsapp.description).to have_content(I18n.t('contact_panels.chat.offline.description', hours: '8am to 8pm'))
end

Then(/^I should see a message informing me that WhatsApp chat will be online tomorrow with tomorrow's opening hours$/) do
  expect(home_page.whatsapp.description).to have_content(I18n.t('contact_panels.chat.offline.description', hours: '8am to 8pm'))
end

Then(/^I should see a message informing me that WhatsApp chat is only available in English$/) do
  expect(home_page.whatsapp).to have_smallprint
end

# May not include this one if too complex
# When (/^I visit the website on a desktop device$/) do
#   pending # Write code here that turns the phrase above into concrete actions
#   expect(home_page.whatsapp).to have_javascript_warning
#   print home_page.whatsapp
#   home_page.load()
#   save_and_open_page
# end

# Then(/^I should not see the WhatsApp chat$/) do
#   pending # Write code here that turns the phrase above into concrete actions
# end
