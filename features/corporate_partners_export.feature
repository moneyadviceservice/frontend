Feature: Export Corporate Partners
  As a MAS partnerships user
  I would like to be able to see a list of all corporate partners via a spreadsheet
  So I may send marketing materials to corporate partners

  Scenario: Authentication not required
    Given I visit the export corporate partners url
    Then  I am granted access
    And   I should be presented a csv file of all corporate partners

  @export-corporate-partners @auth-required
  Scenario: Successfully authenticating and exporting corporate partners
    Given I authenticate with valid credentials
    When  I visit the export corporate partners url
    Then  I am granted access
    And   I should be presented a csv file of all corporate partners

  @auth-required
  Scenario: Unsuccessfully authenticating
    Given I authenticate with invalid credentials
    When  I visit the export corporate partners url
    Then  I am denied access
