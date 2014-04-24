Feature: View the Mortgage Calculator
  As a visitor to the website
  I want to view the Mortgage Calculator
  So I can can see how much my mortgage might be

  Scenario Outline: View the Mortgage Calculator
    When I view the Mortgage Calculator in <language>
    Then I should see the Mortgage Calculator in <language>

  Examples:
    | language |
    | English  |
    | Welsh    |