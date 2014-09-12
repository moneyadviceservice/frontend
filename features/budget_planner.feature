@enable-budget-planner @enable-registration
Feature: View the Budget Planner
  As a visitor to the website
  I want to view the Budget Planner
  So I can can plan my budget

  Scenario Outline: View the Budget Planner
    When I view the Budget Planner in <language>
    Then I should see the Budget Planner in <language>

  Examples:
    | language |
    | English  |
    | Welsh    |

  Scenario Outline: Translate the Budget Planner
    Given I view the Budget Planner in <original_language>
    When I translate the Budget Planner into <translated_language>
    Then I should see the Budget Planner in <translated_language>

  Examples:
    | original_language | translated_language |
    | English           | Welsh               |
    | Welsh             | English             |
