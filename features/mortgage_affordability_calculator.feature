Feature: View the Mortgage Affordability Calculator
  As a visitor to the website
  I want to view the Mortgage Affordability Calculator
  So I can see how much a mortgage might cost me per month

  Scenario Outline: View the Mortgage Affordability Calculator
    When I view the Mortgage Affordability Calculator in <language>
    Then I should see the Mortgage Affordability Calculator in <language>

  Examples:
    | language |
    | English  |
    | Welsh    |

  Scenario Outline: Translate the Mortgage Affordability Calculator
    Given I view the Mortgage Affordability Calculator in <original_language>
    When I translate the Mortgage Affordability Calculator into <translated_language>
    Then I should see the Mortgage Affordability Calculator in <translated_language>

  Examples:
    | original_language | translated_language |
    | English           | Welsh               |
    | Welsh             | English             |
