When(/^I sign in$/) do
  sign_in_page.load
end

Then(/^Sign in is not implemented$/) do
  expect(status_code).to eql(501)
end
