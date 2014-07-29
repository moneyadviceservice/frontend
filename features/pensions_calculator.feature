@enable-pensions-calculator
Feature: View the Pensions Calculator
  As a visitor to the website
  I want to view the Pensions Calculator
  So I can can see how much my pension might be

  Scenario Outline: View the Pensions Calculator
    When I view the Pensions Calculator in <language>
    Then I should see the Pensions Calculator in <language>

  Examples:
    | language |
    | English  |
    | Welsh    |
