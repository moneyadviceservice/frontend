Feature: Corporate Tool Page
  As a corporate MAS partner about to get a MAS tool embed code
  I fill in the name of my organisation and email address before getting the code
  So the MAS partnership team knows who took the code.

  @enable-corporate-tool-directory
  Scenario: Accessing an individual corporate tool page
    When I visit a corporate tool page
    Then I should be on the corporate tool page

  @enable-corporate-tool-directory
  Scenario: Requesting tool embed code
    When I visit a corporate tool page
    And  I fill out my organisation name
    And  I fill out my organisation email
    And  I specify the language I want the tool in
    And  I specify the width of the tool
    And  I request for the embded code
    Then I should be presented with the embed code
    And  I should see a successful confirmation of my details submitted

  Scenario: A corporate tool page is not accessible when feature is disabled
    When I visit a corporate tool page
    Then I am told that the functionality is not implemented
