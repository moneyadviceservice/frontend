Given(/^I am viewing an article with callback disabled$/) do
  browse_to_article article_without_callback_requester
end

Given(/^I am viewing an article with callback enabled$/) do
  browse_to_article article_with_callback_requester
end

Then(/^I should( not)? see the callback requester panel$/) do |negated|
  if negated
    expect(page).to_not have_content 'Request a callback'
  else
    expect(page).to have_content 'Request a callback'
  end
end
