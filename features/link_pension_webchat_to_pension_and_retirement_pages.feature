Feature: Toggle display of TPAS Pension helpline banner
  As a user looking at retirement information, considering webchat,
  I would like the option of talking to a pension specialist
  In order to get answers to specific questions.
  And save me time compared to queueing for MAS webchat only to be passed onto TPAS later.

  Scenario Outline: Visit any page within the Pension and Retirement category
    When I visit any page within the Pension and Retirement category in my "<language>"
    Then I should see a clickable banner
    And the banner should contain this "<message>"

    Examples:
      | language | message |
      | English  | Got a pension question? Ask the pension specialists. No jargon. Just friendly guidance. For free |
      | Welsh    | Gofynnwch i'r arbenigwyr ar bensiynau. Dim jargon. Cyngor cyfeillgar syml. Am ddim |

  Scenario Outline: Visit any page not within the Pension and Retirement category
    Given I visit the home page in my "<language>"
    Then I should not see a clickable banner
    And the banner should not contain this "<message>"

    Examples:
      | language | message |
      | English  | Got a pension question? Ask the pension specialists. No jargon. Just friendly guidance. For free |
      | Welsh    | Gofynnwch i'r arbenigwyr ar bensiynau. Dim jargon. Cyngor cyfeillgar syml. Am ddim |
