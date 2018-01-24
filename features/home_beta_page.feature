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

  Scenario Outline: Most Read
    Given I view the beta home page in <language>
    Then I should be presented with a Most Read section

    Examples:
      | language |
      | English  |
      | Welsh    |

  Scenario Outline: Information guides
    Given I view the beta home page in <language>
    Then I should be presented with the information guides in <language>

    Examples:
      | language |
      | English  |
      | Welsh    |
  
  Scenario Outline: Opt out of beta
    Given I view the beta home page in <language>
    Then I should be presented with the option to return to the current homepage in <language>

    Examples:
      | language |
      | English  |
      | Welsh    |
