Feature: Cookie Disclosure Statemement
  As a webmaster
  I want to provide users with information about the MAS's cookie message
  So that the website complies with EU cookie law

  Scenario: Visiting the site for the first time and seeing the message
    Given I have not previously acknowleged the cookie message
    When I visit the website
    Then I should see the cookie message
    And I can acknowledge I understand

  Scenario: Visiting the site for the first time and seeing the message on subsequent requests
    Given I have not previously acknowleged the cookie message
    And I visit the site and see the cookie message
    When I visit another page
    Then I should see the cookie message

  @with_and_without_javascript
  Scenario: Acknowledging the cookie message
    Given I have not previously acknowleged the cookie message
    And I visit the site and see the cookie message
    When I close the cookie message
    Then I should not see the cookie message

  @with_and_without_javascript
  Scenario: Acknowledging the cookie message and then navigating to another page
    Given I have not previously acknowleged the cookie message
    And I visit the site and acknowledge the cookie message
    When I visit another page
    Then I should not see the cookie message

  Scenario: Visiting the site having previously acknowledged the message
    Given I have previously acknowleged the cookie message
    When I visit the website
    Then I should not see the cookie message
