Given(/^I visit an article( not| NOT)? within the Pension and Retirement category in my "([^"]*)"$/) do |should_not, language|
	article =
    if should_not
      {
        'English' => '/en/articles/saving-money-for-christmas',
        'Welsh' => '/cy/articles/sut-i-gynilo-ar-gyfer-y-nadolig'
      }
    else
      {
        'English' => '/en/articles/personal-pensions',
        'Welsh' => '/cy/articles/pensiynau-personol'
      }
    end

  visit(article[language])
end

Then(/^I should( not|NOT)? see the TPAS banner with "([^"]*)"$/) do |should_not, message|
  if should_not
    expect(page).not_to have_content(message)
  else
    expect(page).to have_content(message)
  end
end
