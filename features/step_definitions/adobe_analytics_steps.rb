When("I view the car cost calculator") do
  visit '/en/tools/car-costs-calculator'
end

Then("I see the correct data layer fields") do
  data_layer = page.evaluate_script('window.adobeDataLayer')

  expect(data_layer.first).to eq(
    {
      "event" => "pageLoad",
      "page"  => {
        "lang"      => "en",
        "pageName"  => "car-cost-tool",
        "pageTitle" => "Car Costs Calculator – Estimate car value, car tax, insurance, depreciation and more",
        "pageType"  => "tool",
        "site"      => "moneyhelper"
      }
    }
  )
end
