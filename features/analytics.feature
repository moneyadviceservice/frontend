Feature: Analytics data
  As a data analyst
  I want to be informed of specific data points
  In order to understand tool usage patterns

  @javascript
  Scenario: Visiting the pensions calculator
    Given I am on the pensions calculator
    Then I should see the correct data for the pensions calculator
