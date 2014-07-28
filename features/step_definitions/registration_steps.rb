When(/^I register$/) do
  sign_up_page.load
end

Then(/^Registration is not implemented$/) do
  expect(status_code).to eql(501)
end
