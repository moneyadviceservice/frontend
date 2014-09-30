Feature: View the Stamp Duty Calculator
  As a visitor to the website
  I want to view the Stamp Duty Calculator
  So I can see how much a mortgage might cost me per month

  Scenario Outline: View the Stamp Duty Calculator
    When I view the Stamp Duty Calculator in <language>
    Then I should see the Stamp Duty Calculator in <language>

  Examples:
    | language |
    | English  |
    | Welsh    |

  Scenario Outline: Translate the Stamp Duty Calculator
    Given I view the Stamp Duty Calculator in <original_language>
    When I translate the Stamp Duty Calculator into <translated_language>
    Then I should see the Stamp Duty Calculator in <translated_language>

  Examples:
    | original_language | translated_language |
    | English           | Welsh               |
    | Welsh             | English             |
