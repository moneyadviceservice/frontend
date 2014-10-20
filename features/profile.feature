Feature: Profile page
  As a registered user
  I want to view my personal profile page
  So that I may manage information particular to my account

  @enable-sign-in @enable-registration @enable-profile
  Scenario:
    Given I am signed in
    When I view my profile page
    Then I see my name
