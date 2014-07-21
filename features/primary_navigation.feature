Feature: Primary Navigation
  As a user reading content
  I want to understand the breadth of the website
  And be able to quickly jump to other relevant sections
  So that I can orientate myself

  Scenario Outline: Primary Navigation for content in 1 category
    Given I am on an <entity> that lives in a single category
    Then I should see the <entity>'s primary navigation with the parent category expanded
    And the relevant <entity>'s child category selected

  Examples:
    | entity      |
    | article     |
    | action_plan |

  Scenario Outline: Primary Navigation for content in 2 categories in the same parent
    Given I am on an <entity> that lives in 2 categories in the same parent
    Then I should see the <entity>'s primary navigation with the parent category expanded
    And the relevant <entity>'s child categories selected

  Examples:
    | entity      |
    | article     |
    | action_plan |

  Scenario Outline: Primary Navigation for content in 2 categories in different parents
    Given I am on an <entity> that lives in 2 categories in different parents
    Then I should see the <entity>'s primary navigation with both parent categories expanded
    And the relevant <entity>'s child categories selected

  Examples:
    | entity      |
    | article     |
    | action_plan |
