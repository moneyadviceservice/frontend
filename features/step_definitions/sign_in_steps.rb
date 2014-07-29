When(/^I attempt to sign in$/) do
  sign_in_page.load
end

Then(/^I am told that the functionality is not implemented$/) do
  expect(status_code).to eql(501)
end
