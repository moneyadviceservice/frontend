Feature: Home page
  As a user visiting the website
  I want to understand who the Money Advice Service are
  So that I easily decide whether to engage further

  Scenario: User sees familiar Money Advice Service brand identity
    When I visit the home page
    Then I should see the Money Advice Service brand identity

  Scenario: User is introduced to the Money Advice Service
    When I visit the home page
    Then I should see an introduction

  Scenario: Welsh user can translate the home page to Welsh
    Given I am on the home page
    When I choose to view the Welsh version
    Then I should see an introduction in my language

  Scenario: User shown information about contacting the call centre
    When I visit the home page
    Then I should see information about contacting the Money Advice Service call centre

  Scenario: User can navigate to Money Advice Service social media profiles
    When I visit the home page
    Then I should be see links to MAS social media profiles
