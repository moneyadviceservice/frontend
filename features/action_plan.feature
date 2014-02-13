Feature: Read an action plan
  As a visitor to the website
  I want to view an action plan
  So I can understand the subject matter

  Scenario: View an action plan
    When I view the action plan
    Then the action plan should be displayed

  Scenario: View an action plan in Welsh
    When I view an action plan in Welsh
    Then I should see the action plan in Welsh

  Scenario Outline: Translate an action plan
    Given I view an action plan in <original_language>
    When I translate the action plan into <translated_language>
    Then I should see the action plan in <translated_language>

  Examples:
  | original_language | translated_language |
  | English           | Welsh               |
  | Welsh             | English             |
