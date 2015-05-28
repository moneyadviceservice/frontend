Feature: Export Corporate Partners
  As a MAS partnerships user
  I would like to be able to see a list of all corporate partners via a spreadsheet
  So I may send marketing materials to corporate partners

  @enable-corporate-tool-directory @export-corporate-partners
  Scenario: Requesting tool embed code
    When I visit the export corporate partners url
    Then I should be presented a csv file of all corporate partners
