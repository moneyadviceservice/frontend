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
  expect(current_page.heading).to have_content(I18n.t('pensions_calculator.global.tool_title', locale: locale))
end

When(/^I translate the Pensions Calculator into (.*)$/) do |language|
  locale           = language_to_locale(language)
  current_language = locale_to_language(I18n.locale)

  expect(current_page.footer_secondary.send("#{language.downcase}_link")[:lang]).to eq(locale)
  expect(current_page.footer_secondary).to_not send("have_#{current_language}_link")

  current_page.footer_secondary.send("#{language.downcase}_link").click
end
