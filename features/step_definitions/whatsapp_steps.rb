# Then("I should be able to start a chat with an advisor via WhatsApp") do
#   pending # Write code here that turns the phrase above into concrete actions
# end

Then(/^I should see a message informing me that I need JavaScript in order chat with an advisor via WhatsApp$/) do
  expect(home_page.whatsapp).to have_javascript_warning
end

# Then("I should not be able to start a chat with an advisor via WhatsApp") do
#   pending # Write code here that turns the phrase above into concrete actions
# end

# Then("I should see a message informing me that WhatsApp chat is currently busy") do
#   pending # Write code here that turns the phrase above into concrete actions
# end

# Then("I should see a message informing me that WhatsApp chat will be online between today's opening hours") do
#   pending # Write code here that turns the phrase above into concrete actions
# end

# Then("I should see a message informing me that WhatsApp chat will be online tomorrow with tomorrow's opening hours") do
#   pending # Write code here that turns the phrase above into concrete actions
# end

# When("I should see a message informing me that WhatsApp chat is only available in English") do
#   pending # Write code here that turns the phrase above into concrete actions
# end

# When("I visit the website on a desktop device") do
#   pending # Write code here that turns the phrase above into concrete actions
# end

# Then("I should not see the WhatsApp chat") do
#   pending # Write code here that turns the phrase above into concrete actions
# end
