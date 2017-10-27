When(/^I visit any page within the Pension and Retirement category in my "([^"]*)"$/) do |language|
  case language
  when 'English'
    visit '/en/retirement-income-options'
  when 'Welsh'
    visit '/cy/opsiynau-incwm-ymddeoliad'
  end
end

Given(/^I visit the home page in my "([^"]*)"$/) do |language|
  case language
  when 'English'
    visit '/en'
  when 'Welsh'
    visit '/cy'
  end
end

Then(/^I should( not| NOT )? see a clickable banner$/) do |should_not|
  if should_not
    expect(page).not_to have_css('.t-pas__stripe_banner')
  else
    expect(page).to have_css('.t-pas__stripe_banner')
  end
end

Then(/^the banner should( not| NOT)? contain this "([^"]*)"$/) do |should_not, message|
  if should_not
    expect(page).not_to have_content(message)
  else
    expect(page).to have_content(message)
  end
end
