Feature: Categories
  As a visitor to the website
  I want to view categories and their contents
  So that I can find information

  Scenario: View a child category
    When I view a category containing no child categories
    Then I should see the category name and description
    And I should see the category content items

  Scenario: View a parent category
    When I view a category containing child categories
    Then I should see the category name and description
    And I should see the child categories
    And I should see the child category content items
