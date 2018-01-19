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
<<<<<<< 1723bb895fca26a46a84eed9ace25b76d0eb1e65

  Scenario Outline: Most Read
    Given I view the beta home page in <language>
    Then I should be presented with a Most Read section

    Examples:
      | language |
      | English  |
      | Welsh    |
||||||| merged common ancestors
=======

  Scenario Outline: Information guides
    Given I view the beta home page in <language>
    Then I should be presented with the information guides in <language>

    Examples:
      | language |
      | English  |
      | Welsh    |
>>>>>>> Adds core markup and UI
