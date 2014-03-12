Feature: View an action plan
  As a visitor to the website
  I want to view an action plan
  So I can understand the subject matter

  Scenario Outline: View an action plan
    When I view the action plan in <language>
    Then I should see the action plan in <language>

  Examples:
    | language |
    | English  |
    | Welsh    |

  Scenario Outline: Translate an action plan
    Given I view the action plan in <original_language>
    When I translate the action plan into <translated_language>
    Then I should see the action plan in <translated_language>

  Examples:
    | original_language | translated_language |
    | English           | Welsh               |
    | Welsh             | English             |
