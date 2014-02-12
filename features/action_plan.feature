Feature: Action Plan Reading
  As a visitor to the website
  I want to view an action plan
  So that I can understand the subject matter

  Scenario: Viewing a published action plan
    Given that there is an action plan
    And it is published
    When I view an action plan
    Then the action plan should be displayed

  Scenario: Viewing an unpublished action plan
    Given that I have a link to an action plan
    And it is unpublished
    When I visit the link
    Then I should see an error page

  Scenario: View welsh action plan
    Given I am viewing an action plan
    When I choose to view the Welsh version
    Then I should see an action plan in my language