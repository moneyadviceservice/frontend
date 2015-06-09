Feature: Export Corporate Partners
  As a MAS partnerships user
  I would like to be able to see a list of all corporate partners via a spreadsheet
  So I may send marketing materials to corporate partners

  @enable-corporate-tool-directory
  Scenario: Authentication not required
    Given I visit the export corporate partners url
    Then  I am granted access
    And   I should be presented a csv file of all corporate partners

  @enable-corporate-tool-directory @export-corporate-partners @auth-required
  Scenario: Successfully authenticating and exporting corporate partners
    Given I authenticate with valid credentials
    When  I visit the export corporate partners url
    Then  I am granted access
    And   I should be presented a csv file of all corporate partners

  @enable-corporate-tool-directory @auth-required
  Scenario: Unsuccessfully authenticating
    Given I authenticate with invalid credentials
    When  I visit the export corporate partners url
    Then  I am denied access
