Feature: Viewing the Debt Management Campaign
  As a visitor to the website
  I want to view the debt management campaign
  So that I can gain advice on managing my debts

  Scenario Outline: Visit the debt management page
    When I view the debt management page in <language>
    Then I should see the debt management page in <language>

  Examples:
    | language |
    | English  |
    | Welsh    |

  Scenario Outline: Visit the debt management non fca firms list
    When I view the debt management non fca firms list in <language>
    Then I should see the debt management non fca firms list in <language>

  Examples:
    | language |
    | English  |
    | Welsh    |
