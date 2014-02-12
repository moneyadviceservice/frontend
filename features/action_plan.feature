Feature: Read an Action Plan
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
    Then I should see an error page

  Scenario: View an action plan in Welsh
    Given I view an action plan
    When I view the Welsh version
    Then I should see the action plan in Welsh