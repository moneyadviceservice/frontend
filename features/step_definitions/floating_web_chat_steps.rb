When(/^I am within business hours$/) do
	step 'chat is online'
end

Then(/^I should see the floating web chat$/) do
    expect(home_page).to have_css('.t__floating-web-chat')
end

Given(/^that I am not on the homepage$/) do
    browse_to_article article('welsh')
end

Then(/^I should not see the floating web chat$/) do
    expect(page).to_not have_css('.t__floating-web-chat')
end