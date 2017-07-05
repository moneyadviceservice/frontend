Feature: Clear data on signout
As a user of the Manager Manager tool
In order to protect my sensitive details
I want all my details to be cleared when I sign out of the tool after using it

  Scenario: Signed out after completing questionnaire
    Given I am on the Money Manager tool
    And   I am signed in
    When  I complete the series of questions
    And   I get my results
    And   I sign out
    And   I should be at the Money Manager landing page
    Then  I should not see any hint of my details when I re-visit the tool