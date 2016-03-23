Feature: Skip to main link
  As a MAS user
  I want to skip to the main content
  So that I can easily navigate the page

  Scenario: Visiting the homepage
    When I visit the homepage
    Then I should be able to skip to the main content

  Scenario: Viewing an article
    When I view an article
    Then I should be able to skip to the main article content

  Scenario: Visiting a category page
    When I visit a category page
    Then I should be able to skip to the categories list
