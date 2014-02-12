Feature: Read an action plan
  As a visitor to the website
  I want to view an action plan
  So I can understand the subject matter

  Scenario: View a published action plan
    Given there is an action plan
    And it is published
    When I view the action plan
    Then the action plan should be displayed

  Scenario: View an unpublished action plan
    Given I have a link to an action plan
    And it is unpublished
    When I visit the link
    Then I should see that the action plan is not found

  Scenario: View an action plan in Welsh
    When I view an action plan in Welsh
    Then I should see the action plan in Welsh

  Scenario outline: Translate an action plan
    Given I view an action plan in <original_language>
    When I translate the action plan into <translated_language>
    Then I should see the action plan in <translated_language>

  Examples:
  | original_language | translated_language |
  | English           | Welsh               |
  | Welsh             | English             |