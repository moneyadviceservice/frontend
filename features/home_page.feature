Feature: Home page
  As a user visiting the website
  I want to understand who the Money Advice Service are
  So that I easily decide whether to engage further

  Scenario: User sees familiar Money Advice Service brand identity
    When I visit the home page
    Then I should see the Money Advice Service brand identity

  Scenario: User shown a message to gain trust
    When I visit the home page
    Then I should see a message to gain my trust

  Scenario: User show featured topics
    When I visit the home page
    Then I should see directory items

  Scenario: User shown information about contacting the call centre
    When I visit the home page
    Then I should see information about contacting the Money Advice Service call centre

  Scenario: User show promoted content
    When I visit the home page
    Then I should see promoted content

  Scenario: User can navigate to Money Advice Service social media profiles
    When I visit the home page
    Then I should be see links to MAS social media profiles

  Scenario: Welsh user can translate the home page to Welsh
    Given I am on the home page
    When I choose to view the Welsh version
    Then I should see a message in my language to gain my trust
