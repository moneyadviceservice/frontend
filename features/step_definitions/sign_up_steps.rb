When(/^I sign up$/) do
  sign_up_page.load
end

Then(/^Sign up is not implemented$/) do
  expect(status_code).to eql(501)
end
