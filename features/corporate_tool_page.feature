Feature: Corporate Tool Page
  As a corporate MAS partner about to get a MAS tool embed code
  I fill in the name of my organisation and email address before getting the code
  So the MAS partnership team knows who took the code.

  Scenario: Accessing an individual corporate tool page
    When I visit a corporate tool page
    Then I should be on the corporate tool page

  Scenario: Requesting tool embed code
    When I visit a corporate tool page
    And  I fill out my organisation name
    And  I fill out my organisation email
    And  I specify the language I want the tool in
    And  I specify the width of the tool
    And  I request for the embded code
    Then I should be presented with the embed code
    And  I should see a successful confirmation of my details submitted

  Scenario: Re-requesting tool embed code
    Given I have received an embed code
    When  I visit a corporate tool page
    And   I fill out my organisation name
    And   I fill out my organisation email
    And   I specify the language I want the tool in
    And   I specify the width of the tool
    And   I request for the embded code
    Then  I should be presented with the embed code
    And   I should see a successful confirmation of my details submitted
