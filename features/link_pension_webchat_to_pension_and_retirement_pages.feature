Feature: Toggle display of TPAS Pension helpline banner
  As a user looking at retirement information, considering webchat,
  I would like the option of talking to a pension specialist
  In order to get answers to specific questions.
  And save me time compared to queueing for MAS webchat only to be passed onto TPAS later.

  Scenario Outline: Visit an aticle within the Pension and Retirement category
    Given I visit an article within the Pension and Retirement category in my "<language>"
    Then I should see the TPAS banner with "<message>"

    Examples:
      | language | message |
      | English  | Got a pension question? Ask the pension specialists. No jargon. Just friendly guidance. For free |
      | Welsh    | Gofynnwch i'r arbenigwyr ar bensiynau. Dim jargon. Cyngor cyfeillgar syml. Am ddim |

  Scenario Outline: Visit an article not within the Pension and Retirement category
    Given I visit an article not within the Pension and Retirement category in my "<language>"
    Then I should not see the TPAS banner with "<message>"

    Examples:
      | language | message |
      | English  | Got a pension question? Ask the pension specialists. No jargon. Just friendly guidance. For free |
      | Welsh    | Gofynnwch i'r arbenigwyr ar bensiynau. Dim jargon. Cyngor cyfeillgar syml. Am ddim |
