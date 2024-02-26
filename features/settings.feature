Feature: Settings
  As a Registered MAS user,
  I want to be able to update my details
  so that MAS has my most up to update information.

  Scenario: Updating name
    Given I am signed in
    And   I am on the settings page
    And   I update my first name to "John"
    Then  I should see a successful update notification

  Scenario: Updating email
    Given I am signed in
    And   I am on the settings page
    And   I update my email address to "jon@example.com"
    Then  I should see a successful update notification

  Scenario: Updating password
    Given I am signed in
    And   I sign in elsewhere
    And   I am on the settings page
    And   I update password to "new password"
    And   I will be logged out
    And   I will be logged out elsewhere

  Scenario: Updating post code
    Given I am signed in
    And   I am on the settings page
    And   I update post code to "NW1 8TY"
    Then  I should see a successful update notification
