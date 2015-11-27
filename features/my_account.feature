Feature: My Account
  As a Registered User
  I want to view my Account
  So I can receive personalised information

  Scenario: Feature enabled
    Given I am signed in
    And   I am on the home page
    When  I click on "My Account"
    Then  I see my account page
