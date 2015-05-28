When(/^I visit the export corporate partners url$/) do
  visit export_partners_corporate_index_path(locale: I18n.locale)
end

Then(/^I should be presented a csv file of all corporate partners$/) do
  @corporate_partners = CorporatePartner.all
  csv = CSV.parse(page.body)
  corporate_partner_line = CSV.parse(@corporate_partners.to_csv).last
  expect(csv).to include(corporate_partner_line)
end
