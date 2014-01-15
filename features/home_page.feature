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
    Then I should see the content in Welsh

  Scenario: User can navigate to Money Advice Service social media profiles
    Given I am on the home page
    When I navigate to a social media profile
    Then I should be taken to that social media profile
