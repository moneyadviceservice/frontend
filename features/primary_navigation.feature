@fake-articles
Feature: Primary Navigation
  As a user reading an article
  I want to understand the breadth of the website
  And be able to quickly jump to other relevenat sections
  So that I can orientate myself

  Scenario: Primary Navigation for an article in 1 category
    Given I am on an article that lives in a single category
    Then I should see the primary navigation with the parent category expanded
    And the relevant child category selected

  Scenario: Primary Navigation for an article in 2 categories in the same parent
    Given I am on an article that lives in 2 categories in the same parent
    Then I should see the primary navigation with the parent category expanded
    And the relevant child categories selected
