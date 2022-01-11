Then(/^I should be able to change my password$/) do
  change_password_page.password.set 'securePassword'
  change_password_page.password_confirmation.set 'securePassword'

  # rack-test does not handle external redirects so verify this way
  begin
    change_password_page.submit.click
  rescue ActionController::RoutingError
    expect(current_url).to eq('https://www.moneyhelper.org.uk/en/users/my-profile')
  end
end
