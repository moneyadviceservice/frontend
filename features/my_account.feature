Feature: My Account
  As a Registered User
  I want to view my Account
  So I can receive personalised information

  @enable-profile
  Scenario: Feature enabled
    Given I am signed in
    And   I am on the home page
    When  I click on "My Account"
    Then  I see my account page

  Scenario: Feature disabled
    Given I am signed in
    And   I am on the home page
    When  I click on "My Account"
    Then  I don't see my account page
