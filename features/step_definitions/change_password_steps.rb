Then(/^I should be able to change my password$/) do
  change_password_page.password.set 'securePassword'
  change_password_page.password_confirmation.set 'securePassword'
  change_password_page.submit.click 
  step 'I should be signed in'
end
