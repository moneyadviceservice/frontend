@wip
Feature: Cookie Disclosure Statemement
  As a webmaster
  I want to provide users with information about the MAS's cookie policy
  So that the website complies with EU cookie law

  Scenario: User visits the site for the first time
    Given I have not already acknowleged I understand the cookie policy
    When I visit the website
    Then I should see the cookie notice
    And I can acknowlege I understand

  Scenario: Cookie message persists on navigation if not closed
    Given I have not already acknowleged I understand the cookie policy
    And I have visited the site and seen the cookie policy
    When I navigate to another page
    Then I should see the cookie notice

  Scenario: Dismissing the cookie policy
    Given I have not already acknowleged I understand the cookie policy
    And I have visited the site and seen the cookie policy
    When I close the cookie notice
    Then the cookie policy is hidden

  Scenario: Dismissing the cookie policy and then navigating to another page
    Given I have not already acknowleged I understand the cookie policy
    And I have visited the site and dismissed the cookie policy
    When I navigate to another page
    Then I should not see the cookie notice

  Scenario: User visits the site having previously dismissed the message
    Given I have already acknowleged I understand the cookie policy
    When I visit the website
    Then I should not see the cookie notice

  Scenario: User manually toggles the cookie policy
    Given I have already acknowleged I understand the cookie policy
    When I visit the website
    And I click on the "Cookie Policy" link in the footer
    Then I should see the cookie notice
