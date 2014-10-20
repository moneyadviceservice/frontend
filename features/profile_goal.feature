Feature:
  As a register user
  I want to set a goal and date by when I should achieve my goal
  So that I affirm my commitment to improving my financial situation

  @enable-sign-in @enable-registration @enable-profile
  Scenario: My goal is blank if I've never set it
    Given I am signed in
    When I view my profile page
    Then I see my goal and goal date is blank

  @enable-sign-in @enable-registration @enable-profile
  Scenario: My goal is saved when I fill it in and save it
    Given I am signed in
    And I view my profile page
    When I set a new goal and goal date
    Then I see my goal and goal date
