Feature: Settings
  As a Registered MAS user,
  I want to be able to update my details
  so that MAS has my most up to update information.

@enable-profile @enable-settings
Scenario: Updating name
  Given I am signed in
  And   I am on the settings page
  And   I update my first name to "John"
  Then  I should see a successful update notification

@enable-profile @enable-settings
Scenario: Updating email
  Given I am signed in
  And   I am on the settings page
  And   I update my email address to "jon@example.com"
  Then  I should see a successful update notification

@enable-profile @enable-settings
Scenario: Updating password
  Given I am signed in
  And   I am on the settings page
  And   I update password to "new password"
  Then  I should see a successful update notification

@enable-profile @enable-settings
Scenario: Updating post code
  Given I am signed in
  And   I am on the settings page
  And   I update post code to "NW1 8TY"
  Then  I should see a successful update notification

@enable-profile @enable-settings
Scenario: Updating newsletter opt-in
  Given I am signed in
  And   I am on the settings page
  And   I opt out of MAS newsletters
  Then  I should see a successful update notification

Scenario: User can't update their details when the feature is disabled
  Given I am signed in
  And   I try to view the settings page
  Then  I am told that the functionality is not implemented
