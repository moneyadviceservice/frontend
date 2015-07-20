Given(/^I am on the MAS account registration page$/) do
  sign_up_page.load(locale: 'en')
end

Then(/^I should have the option to opt\-in or opt\-out of participating in research$/) do
  find('#user_opt_in')
end
