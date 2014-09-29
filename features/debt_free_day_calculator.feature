Feature: View one of the Debt Free Day Calculators
  As a visitor to the website
  I want to use the Debt Free Day Calculators
  So I can can understand how long it will take me to be debt free

  Scenario Outline: View the Loan Calculator
    When I view the Loan Calculator in <language>
    Then I should see the Loan Calculator in <language>

  Examples:
    | language |
    | English  |
    | Welsh    |

  Scenario Outline: Translate the Loan Calculator
    Given I view the Loan Calculator in <original_language>
    When I translate the Loan Calculator into <translated_language>
    Then I should see the Loan Calculator in <translated_language>

  Examples:
    | original_language | translated_language |
    | English           | Welsh               |
    | Welsh             | English             |


  Scenario Outline: View the Credit Card Calculator
    When I view the Credit Card Calculator in <language>
    Then I should see the Credit Card Calculator in <language>

  Examples:
    | language |
    | English  |
    | Welsh    |

  Scenario Outline: Translate the Credit Card Calculator
    Given I view the Credit Card Calculator in <original_language>
    When I translate the Credit Card Calculator into <translated_language>
    Then I should see the Credit Card Calculator in <translated_language>

  Examples:
    | original_language | translated_language |
    | English           | Welsh               |
    | Welsh             | English             |
