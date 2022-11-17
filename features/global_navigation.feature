@wip
Feature: Global Navigation
  As an content provider
  I want to be able to show the global navigation in both english and welsh
  In order to provide information for the whole nation

  Scenario: Acessing the english site
    Given I am on the home page
    Then I should see the global navigation
      | Main navigation    |
      | Debt & Borrowing   |
      | Homes & Mortgages  |
      | Work & Benefits    |
      | Retirement         |
      | Family             |
      | Cars & Travel      |
      | Insurance          |

  Scenario: Acessing the welsh site
    Given I visit the website in Welsh
    Then I should see the global navigation
      | Main navigation       |
      |  Dyled a benthyca     |
      |  Cartrefi a morgeisi  |
      |  Cyllidebu a Chynilo  |
      |  Gwaith a Buddion     |
      |  Ymddeoliad           |
      |  Teulu                |
      |  Ceir a theithio      |
      |  Yswiriant            |
