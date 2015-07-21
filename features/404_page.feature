Feature: 404 page

  Scenario: page doesn't exist
    Given that I visit a non-existent link
    Then I should see a page not found message
