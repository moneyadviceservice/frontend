When(/^I visit the website on "(.*?)"$/) do |migration_date|

  on_migration_date = Chronic.parse(migration_date)

  Timecop.freeze(on_migration_date) do
    step 'I visit the website'
  end

end

When(/^I visit the website on an active chat "(.*?)"$/) do |date|

  on_active_chat_date = Chronic.parse(date)

  Timecop.freeze(on_active_chat_date) do
    step 'I visit the website'
  end

end

Then(/^I should see the chat offline migration message$/) do

  expect(home_page.chat.opening_times)
    .to have_content('On Saturday 06/02/2016 Web chat will be unavailable due to maintenance')

end

Then(/^I should not see the chat offline migration message$/) do

  expect(home_page.chat.opening_times)
    .to have_content('Saturday, 9am to 1pm')

end
