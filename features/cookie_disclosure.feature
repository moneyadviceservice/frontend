Feature: Cookie Disclosure Statemement
  In order to comply with EU law
  As a webmaster
  I want to provide users with information about the MAS's cookie policy

  Scenario: User visits the site for the first time
    Given I have no cookies stored
    When I visit the home page
    Then the home page contains the cookie message
    And the home page contains an option to close the cookie message

  Scenario: Cookie message persists on navigation if not closed
    Given I have no cookies stored
    When I visit the home page
    And the home page contains the cookie message
    And I navigate from the home page to the partners page
    Then the partners page contains the cookie message

  Scenario: Dismissing the cookie message
    Given I have no cookies stored
    When I visit the home page
    And the home page contains the cookie message
    And I close the cookie message
    Then the home page does not contain the cookie message

  Scenario: Dismissing the cookie message and then navigates to another page
    Given I have no cookies stored
    When I visit the home page
    And the home page contains the cookie message
    And I close the cookie message
    And the home page does not contain the cookie message
    And I navigate from the home page to the partners page
    Then the partners page does not contain the cookie message

  Scenario: User visits the site having previously dismissed the message
    Given I have a persistent cookie notice stored
    When I visit the home page
    Then the home page does not contain the cookie message

  Scenario: User visits the site having dismissed the message a year ago
    Given I have a year old persistent cookie notice stored
    When I visit the home page
    Then the home page contains the cookie message

  Scenario: User manually invokes the cookie notice
    Given I have a persistent cookie notice stored
    When I visit the home page
    And the home page does not contain the cookie message
    When I click on the "Cookie Policy" link in the footer
    Then I see the cookie message

  Scenario: User manually invokes the cookie notice and then navigates to another page
    Given I have a persistent cookie notice stored
    And I visit the home page
    And I click on the "Cookie Policy" link in the footer
    When I navigate from the home page to the partners page
    Then the partners page does not contain the cookie message
