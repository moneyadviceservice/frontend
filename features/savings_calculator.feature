Feature: View the Savings Calculator
  As a visitor to the website
  I want to view the Savings Calculator
  So I can can see how much my pension might be

  @enable-savings_calculator
  Scenario Outline: View the Savings Calculator
    When I view the Savings Calculator in <language>
    Then I should see the Savings Calculator in <language>

  Examples:
    | language |
    | English  |
    | Welsh    |

  @enable-savings_calculator
  Scenario Outline: Translate the Savings Calculator
    Given I view the Savings Calculator in <original_language>
    When I translate the Savings Calculator into <translated_language>
    Then I should see the Savings Calculator in <translated_language>

  Examples:
    | original_language | translated_language |
    | English           | Welsh               |
    | Welsh             | English             |
