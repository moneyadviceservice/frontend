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

  Scenario Outline: Translate the Pensions Calculator
    Given I view the Pensions Calculator in <original_language>
    When I translate the Pensions Calculator into <translated_language>
    Then I should see the Pensions Calculator in <translated_language>

  Examples:
    | original_language | translated_language |
    | English           | Welsh               |
    | Welsh             | English             |
