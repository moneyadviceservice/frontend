Feature: Read an action plan
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


