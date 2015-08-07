Given(/^an unregistered user visits the MAS site$/) do
  step 'I visit the website'
end

When(/^I scroll to the bottom of the page$/) do
  page.execute_script "window.scrollBy(0,10000)"
end

Then(/^I should see a sticky newsletter sign up form$/) do
  expect(current_page).to have_sticky_newsletter
end

When(/^I dismiss the newsletter$/) do
  save_and_open_page
  current_page.sticky_newsletter.close_button.click
end

Then(/^I should not see it again when I re\-visit the site$/) do
    pending # express the regexp above with the code you wish you had
end
