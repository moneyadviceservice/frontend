Feature:
  As a registered user
  I want to view the tools that I have saved data for
  So that I can continue with or review a particular tool

  @enable-profile
  Scenario: No saved data shows a message
    Given I am signed in with warden
    And I have no saved data for any tools
    When I view my profile page
    Then I see a message prompting me to try a tool

  @enable-profile
  Scenario: Saved data for budget planner
    Given I am signed in with warden
    And I have saved data for the "budget_planner" tool
    When I view my profile page
    Then I see the "Budget Planner" tool listed under saved tools

  @enable-profile
  Scenario: Saved data for health check
    Given I am signed in with warden
    And I have saved data for the "health_check" tool
    When I view my profile page
    Then I see the "Health Check" tool listed under saved tools
