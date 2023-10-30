When("I view the WPCC") do
  visit '/en/tools/workplace-pension-contribution-calculator'
end

When("I complete the first step") do
  fill_in 'Your age', with: '55'
  fill_in 'Your salary', with: '65000'
  click_on 'Next'
end

Then("I see the correct data layer fields for WPCC") do
  data_layer = page.evaluate_script('window.adobeDataLayer')

  expect(data_layer.first).to eq(
    {
      "event" => "pageLoad",
      "page"  => {
        "lang"      => "en",
        "pageName"  => "wpcc",
        "pageTitle" => "Workplace pension contribution calculator Your contributions",
        "pageType"  => "tool",
        "site"      => "moneyhelper"
      }
    }
  )
end
