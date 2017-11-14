Feature: Money Manager
As a user of the Manager Manager tool
I want my answers to be saved when I register or sign in
And I want all my details to be cleared when I sign out

  Scenario: Signed out after completing questionnaire
    Given I am on the Money Manager tool
    And   I am signed in
    When  I complete the series of questions
    And   I get my results
    And   I sign out
    Then  I should not see any hint of my details when I re-visit the tool

  Scenario: Signing in after completing questionnaire saves answers
    Given I am on the Money Manager tool
    And   I complete the series of questions
    And   I sign in
    And   I sign out
    When  I am on the Money Manager tool
    And   I select a country
    And   I sign in
    Then  I get my results
    
  Scenario: Signing in should overwrite old answers with new ones
    Given I am signed in
    And   I am on the Money Manager tool
    And   I complete the series of questions
    And   I sign out
    When  I am on the Money Manager tool
    And   I answer the questions differently
    And   I sign in
    Then  I have the latest answers

Scenario: Signing in with new country
    Given I am signed in
    And   I am on the Money Manager tool
    And   I complete the series of questions
    And   I sign out
    When  I am on the Money Manager tool
    And   I select a different country
    And   I sign in
    Then  I get my results for the different country