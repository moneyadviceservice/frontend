When(/^I view the Mortgage Affordability Calculator in (.*)$/) do |language|
  locale = language_to_locale(language).to_sym
  paths = {
    en:  "/en/tools/house-buying/mortgage-affordability-calculator",
    cy:  "/cy/tools/prynu-ty/cyfrifiannell-fforddiadwyedd-morgais",
  }

  visit paths[locale]
end

Then(/^I should see the Mortgage Affordability Calculator in (.*)$/) do |language|
  locale = language_to_locale(language).to_sym

  expect(current_page).to have_content(I18n.t('affordability.title', locale: locale))
end

When(/^I translate the Mortgage Affordability Calculator into (.*)$/) do |language|
  locale           = language_to_locale(language)
  current_language = locale_to_language(I18n.locale)

  expect(current_page.footer_secondary.send("#{language.downcase}_link")[:lang]).to eq(locale)
  expect(current_page.footer_secondary).to_not send("have_#{current_language}_link")

  current_page.footer_secondary.send("#{language.downcase}_link").click
end
