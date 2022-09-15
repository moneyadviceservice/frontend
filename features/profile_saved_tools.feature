Feature:
  As a registered user
  I want to view the tools that I have saved data for
  So that I can continue with or review a particular tool

  Scenario: No saved data shows a message
    Given I am signed in with warden
    And I have no saved data for any tools
    When I view my profile page
    Then I see a message prompting me to try a tool

  Scenario: Saved data for budget planner
    Given I am signed in with warden
    And I have saved data for the "budget_planner" tool
    When I view my profile page without resize
    Then I see the "Review and edit your saved budget now" link listed under saved tools
    And the link persists without resize

  Scenario: Saved data for universal credit
    Given I am signed in with warden
    And I have saved data for the "universal_credit" tool
    When I view my profile page
    Then I see the "View your personal advice plan or update your circumstances" link listed under saved tools
