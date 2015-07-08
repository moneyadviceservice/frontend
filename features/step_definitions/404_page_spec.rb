Given(/^that I visit a non\-existent link$/) do
  visit '/en/bad'
end

Then(/^I should see a page not found message$/) do
    pending # express the regexp above with the code you wish you had
end
