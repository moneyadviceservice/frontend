Feature: Skip to main link
  As a MAS user
  I want to skip to the main content
  So that I can easily navigate the page

  Scenario: Visiting the homepage
    When I visit the homepage
    Then the main area is immediately after the header

  Scenario: Viewing an article
    When I view an article
    Then the main area is at the article content

  Scenario: Visiting a category page
    When I visit a category page
    Then the main area is at the categories list
