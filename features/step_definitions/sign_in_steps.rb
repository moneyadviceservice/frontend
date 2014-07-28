When(/^I attempt to sign in$/) do
  sign_in_page.load
end

Then(/^Then I am directed to the old website$/) do
  expect(status_code).to eql(501)
end
