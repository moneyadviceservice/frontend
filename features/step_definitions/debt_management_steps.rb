When(/^I view the debt management page in (.*)$/) do |language|
  locale = language_to_locale(language)
  debt_management_page.load(locale: locale)
end

Then(/^I should see the debt management page in (.*)$/) do |language|
  locale = language_to_locale(language)

  I18n.with_locale(locale) do
    expect(debt_management_page.heading.text).to eq(I18n.t('page_heading'))
  end
end

When(/^I view the debt management non fca firms list in (.*)$/) do |language|
  locale = language_to_locale(language)
  debt_management_companies_page.load(locale: locale)
end

Then(/^I should see the debt management non fca firms list in (.*)$/) do |language|
  locale = language_to_locale(language)

  I18n.with_locale(locale) do
    expect(debt_management_companies_page.heading.text).to eq(I18n.t('companies.standalone_title'))
  end
end
