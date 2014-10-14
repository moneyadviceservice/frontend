Before do
  @i18n_key_prefix = 'debt_free_day_calculator.calculations.header.heading.debt_free_day_calculator/'
end

When(/^I view the Loan Calculator in (.*)$/) do |language|
  locale = language_to_locale(language).to_sym
  paths = {
    en:  "/en/tools/#{ToolMountPoint::DebtFreeDayCalculator::LoanCalculator::EN_ID}",
    cy:  "/cy/tools/#{ToolMountPoint::DebtFreeDayCalculator::LoanCalculator::CY_ID}",
  }

  visit paths[locale]
end

Then(/^I should see the Loan Calculator in (.*)$/) do |language|
  locale = language_to_locale(language).to_sym
  expect(current_page.heading).to have_content(
    I18n.t("#{@i18n_key_prefix}loan_calculation", locale: locale))
end

When(/^I translate the Loan Calculator into (.*)$/) do |language|
  locale           = language_to_locale(language)
  current_language = locale_to_language(I18n.locale)

  expect(current_page.footer_secondary.send("#{language.downcase}_link")[:lang]).to eq(locale)
  expect(current_page.footer_secondary).to_not send("have_#{current_language}_link")

  current_page.footer_secondary.send("#{language.downcase}_link").click
end

When(/^I view the Credit Card Calculator in (.*)$/) do |language|
  locale = language_to_locale(language).to_sym
  paths = {
    en:  "/en/tools/#{ToolMountPoint::DebtFreeDayCalculator::CreditCardCalculator::EN_ID}",
    cy:  "/cy/tools/#{ToolMountPoint::DebtFreeDayCalculator::CreditCardCalculator::CY_ID}",
  }

  visit paths[locale]
end

Then(/^I should see the Credit Card Calculator in (.*)$/) do |language|
  locale = language_to_locale(language).to_sym
  expect(current_page.heading).to have_content(
    I18n.t("#{@i18n_key_prefix}credit_card_calculation", locale: locale))
end

When(/^I translate the Credit Card Calculator into (.*)$/) do |language|
  locale           = language_to_locale(language)
  current_language = locale_to_language(I18n.locale)

  expect(current_page.footer_secondary.send("#{language.downcase}_link")[:lang]).to eq(locale)
  expect(current_page.footer_secondary).to_not send("have_#{current_language}_link")

  current_page.footer_secondary.send("#{language.downcase}_link").click
end
