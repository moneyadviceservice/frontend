When(/^I visit the category ([\w\-]+) in (English|Welsh)$/) do |category, language|
  locale = language == 'Welsh' ? 'cy' : 'en'
  category_page.load(locale: locale, id: category)
end

When(/^I visit a category with WhatsApp integration in (English|Welsh)$/) do |language|
  step "I visit the category debt-and-borrowing in #{language}"
end

Then(/^I should see a message informing me that WhatsApp chat is only available in English$/) do
  expect(category_page.whatsapp).to have_smallprint
end

Then(/^I should see an unavailable message$/) do
  expect(category_page.whatsapp.unavailable).to have_content(I18n.t('contact_panels.chat.unavailable.call_to_action'))
end

Then(/^I should see a WhatsApp link$/) do
  expect(current_page.whatsapp.link).to be_truthy
end

