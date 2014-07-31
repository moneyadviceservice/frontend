When(/^I view the Pensions Calculator in (.*)$/) do |language|
  locale = language_to_locale(language).to_sym
  paths = {
    en:  "/en/tools/pension-calculator",
    cy:  "/cy/tools/dilyn-hynt-eich-pensiwn-a-chynilion-ymddeoliad-eraill",
  }

  visit paths[locale]
end

Then(/^I should see the Pensions Calculator in (.*)$/) do |language|
  locale = language_to_locale(language).to_sym
  expect(current_page.heading).to have_content(I18n.t('pensions_calculator.intro.heading'))
end
