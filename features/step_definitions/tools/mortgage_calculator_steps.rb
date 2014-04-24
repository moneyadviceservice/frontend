When(/^I view the Mortgage Calculator in (.*)$/) do |language|
  locale = language_to_locale(language).to_sym
  paths = {
    en:  "/en/tools/mortgage-calculator-new",
    cy:  "/cy/tools/cyfrifiannell-morgais-newydd",
  }

  visit paths[locale]
end
