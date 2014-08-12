Feature: Beta opt-out
  As a webmaster
  I want to allow users to opt out of the beta
  So that they can continue to use the previous site

  Scenario: Opting out of the beta
    Given I have not previously opted out of the beta
    And I visit the website
    When I opt out of the beta
    Then the opt out cookie should be set
