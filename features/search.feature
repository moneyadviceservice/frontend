Feature: Searching
  As a user visiting the website
  I want to search by keyword
  So that I can find the content I am looking for

  Scenario: The search box is visible in the header
    When I visit the home page
    Then I should see the search box

  Scenario: Search can be performed
    Given I am on the home page
    When I search for something relevant
    Then I should see search results
