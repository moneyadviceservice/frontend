When(/^I view the Stamp Duty Calculator in (.*)$/) do |language|
  locale = language_to_locale(language).to_sym
  paths = {
    en:  "/en/tools/house-buying/stamp-duty-calculator",
    cy:  "/cy/tools/prynu-ty/cyfrifiannell-treth-stamp",
  }

  visit paths[locale]
end

Then(/^I should see the Stamp Duty Calculator in (.*)$/) do |language|
  locale = language_to_locale(language).to_sym

  expect(current_page).to have_content(I18n.t('stamp_duty.title', locale: locale))
end

When(/^I translate the Stamp Duty Calculator into (.*)$/) do |language|
  locale           = language_to_locale(language)
  current_language = locale_to_language(I18n.locale)

  expect(current_page.footer_secondary.send("#{language.downcase}_link")[:lang]).to eq(locale)
  expect(current_page.footer_secondary).to_not send("have_#{current_language}_link")

  current_page.footer_secondary.send("#{language.downcase}_link").click
end
