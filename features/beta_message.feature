Feature: Beta Message interaction
  As a webmaster
  I want to inform users that the current website is in beta
  So that the they can decide if they would rather opt out of the beta

  Scenario: Visiting the website and seeing the opt out bar
    Given I have not previously dismissed the opt out bar or opted out of the beta
    When I visit the website
    Then I should see the opt out bar
    And I should see the opt out footer button
    And I can choose to dismiss the opt out bar
    And I can choose to opt out of the beta

  Scenario: Visiting the website and seeing the opt out bar and footer link on subsequent requests
    Given I have not previously dismissed the opt out bar or opted out of the beta
    When I visit the website and see the opt out bar
    And I visit another page
    Then I should see the opt out bar
    And I should see the opt out footer button

#  @with_and_without_javascript
  Scenario: Dismissing the opt out bar
    Given I have not previously dismissed the opt out bar or opted out of the beta
    And I visit the website and see the opt out bar
    When I dismiss the opt out bar
    Then I should not see the opt out bar
    And I should see the opt out footer button

#  @with_and_without_javascript
  Scenario: Dismissing the opt out bar and then navigating to another page
    Given I have not previously dismissed the opt out bar or opted out of the beta
    And I visit the website and dismiss the opt out bar
    When I visit another page
    Then I should not see the opt out bar
    And I should see the opt out footer button

  Scenario: Opting out of the beta via the opt out bar button
    Given I have not previously dismissed the opt out bar or opted out of the beta
    And I visit the website and see the opt out bar
    When I opt out of the beta via the opt out bar button
    Then the opt out cookie should be set

  Scenario: Opting out of the beta via the footer button
    Given I have not previously dismissed the opt out bar or opted out of the beta
    And I visit the website
    When I opt out of the beta via the footer button
    Then the opt out cookie should be set

  Scenario: Visiting the website having previously dismissed the opt out bar
    Given I have previously dismissed the opt out bar
    When I visit the website
    Then I should not see the opt out bar
    And I should see the opt out footer button
