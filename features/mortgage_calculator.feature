Feature: View the Mortgage Calculator
  As a visitor to the website
  I want to view the Mortgage Calculator
  So I can see how much a mortgage might cost me per month

  @enable-mortgage_calculator
  Scenario Outline: View the Mortgage Calculator
    When I view the Mortgage Calculator in <language>
    Then I should see the Mortgage Calculator in <language>

  Examples:
    | language |
    | English  |
    | Welsh    |

  @enable-mortgage_calculator
  Scenario Outline: Translate the Mortgage Calculator
    Given I view the Mortgage Calculator in <original_language>
    When I translate the Mortgage Calculator into <translated_language>
    Then I should see the Mortgage Calculator in <translated_language>

  Examples:
    | original_language | translated_language |
    | English           | Welsh               |
    | Welsh             | English             |
