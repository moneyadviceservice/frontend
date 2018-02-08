LINKS_OUTSIDE_PENSIONS_CATEGORY = {
  'article' => {
    'English' => '/en/articles/saving-money-for-christmas',
    'Welsh' => '/cy/articles/sut-i-gynilo-ar-gyfer-y-nadolig'
  },
  'category' => {
    'English' => '/en/categories/help-with-your-benefits',
    'Welsh' => '/cy/categories/help-with-your-benefits'
  },
  'tool' => {
    'English' => '/en/tools/budget-planner',
    'Welsh' => '/cy/tools/cynllunydd-cyllideb/start'
  }
}.freeze

LINKS_WITHIN_PENSIONS_CATEGORY = {
  'article' => {
    'English' => '/en/articles/personal-pensions',
    'Welsh' => '/cy/articles/pensiynau-personol'
  },
  'category' => {
    'English' => '/en/articles/options-for-using-your-pension-pot',
    'Welsh' => '/cy/articles/yr-opsiynau-ar-gyfer-defnyddioch-cronfa-bensiwn'
  },
  'tool' => {
    'English' => '/en/tools/pension-calculator',
    'Welsh' => '/cy/tools/cyfrifiannell-pensiwn/'
  }
}.freeze

Given(/^I visit "([^"]*)" not within the Pension and Retirement category in my "([^"]*)"$/) do |entity, language|
  visit(LINKS_OUTSIDE_PENSIONS_CATEGORY[entity][language])
end

Given(/^I visit "([^"]*)" within the Pension and Retirement category in my "([^"]*)"$/) do |entity, language|
  visit(LINKS_WITHIN_PENSIONS_CATEGORY[entity][language])
end

Then(/^I should( not|NOT)? see the TPAS banner with "([^"]*)"$/) do |should_not, message|
  if should_not
    expect(page).not_to have_content(message)
  else
    expect(page).to have_content(message)
  end
end
