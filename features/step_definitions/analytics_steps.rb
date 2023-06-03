Given('I am on the pensions calculator') do
  visit '/en/tools/pension-calculator'
end

Then('I should see the correct data for the pensions calculator') do
  digital_data = page.evaluate_script('digitalData.tool')

  expect(digital_data).to eq({
    'toolName' => 'pensions-calculator',
    'toolStep' => 'index'
  })
end
