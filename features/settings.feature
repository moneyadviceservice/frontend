Feature: Settings
  As a Registered MAS user,
  I want to be able to update my details
  so that MAS has my most up to update information.

@enable-sign-in @settings
Scenario: Updating name
  Given I have an account
  When  I sign in
  And   I click on 'Update my details'
  And   I update my first name to "Tenacious"
  And   I update my last name to "D"
  Then  I should receive a "Details successfully updated" notification

@enable-sign-in @settings
Scenario: Updating email
  Given I have an account
  When  I sign in
  And   I click on 'Update my details'
  And   I update my email address to "tenaciousd@example.com"
  Then  I should receive a "Details successfully updated" notification

@enable-sign-in @settings
Scenario: Updating password
  Given I have an account
  When  I sign in
  And   I click on 'Update my details'
  And   I update password to "new password"
  Then  I should receive a "Details successfully updated" notification

@enable-sign-in @settings
Scenario: Updating post code
  Given I have an account
  When  I sign in
  And   I click on 'Update my details'
  And   I update post code to "NW1 8TY"
  Then  I should receive a "Details successfully updated" notification

@enable-sign-in @settings
Scenario: Updating newsletter opt-in
  Given I have an account
  When  I sign in
  And   I click on 'Update my details'
  And   I opt out of MAS newsletters
  Then  I should receive a "Details successfully updated" notification

@enable-sign-in
Scenario: User can't update their details when the feature is disabled
  Given I have an account
  When  I sign in
  And   I click on 'Update my details'
  Then I am told that the functionality is not implemented
