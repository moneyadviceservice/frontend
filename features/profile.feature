Feature: Profile page
  As a registered user
  I want to view my personal profile page
  So that I may manage information particular to my account

  Scenario:
    Given I am signed in
    When I view my profile page
    Then I see my name

  Scenario: Viewing a profile page without resize JS
    Given I am signed in
    When I view my profile page without resize
    Then links persist without resize
