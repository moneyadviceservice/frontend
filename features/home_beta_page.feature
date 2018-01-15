Feature: Home page beta
  As a user visiting the beta homepage

  Scenario Outline: Popular tools
    Given I view the beta home page in <language>
    Then I should be presented with popular tools and calculators

    Examples:
      | language |
      | English  |
      | Welsh    |

  Scenario Outline: Seasonal spotlight
    Given I view the beta home page in <language>
    Then I should be presented with the seasonal spotlight in <language>

    Examples:
      | language |
      | English  |
      | Welsh    |
