@wip
Feature: Toggle display of TPAS Pension helpline banner
  As a user looking at retirement information, considering webchat,
  I would like the option of talking to a pension specialist
  In order to get answers to specific questions.
  And save me time compared to queueing for MAS webchat only to be passed onto TPAS later.

  Scenario Outline: Visit "<entity>" within the Pension and Retirement category
    Given I visit "<entity>" within the Pension and Retirement category in my "<language>"
    Then I should see the TPAS banner with "<message>"

    Examples:
      | entity   | language | message |
      | article  | English  | Got a pension question? Ask the pension specialists. No jargon. Just friendly guidance. For free |
      | article  | Welsh    | Gofynnwch i'r arbenigwyr ar bensiynau. Dim jargon. Cyngor cyfeillgar syml. Am ddim |
      | category | English  | Got a pension question? Ask the pension specialists. No jargon. Just friendly guidance. For free |
      | category | Welsh    | Gofynnwch i'r arbenigwyr ar bensiynau. Dim jargon. Cyngor cyfeillgar syml. Am ddim |
      | tool     | English  | Got a pension question? Ask the pension specialists. No jargon. Just friendly guidance. For free |
      | tool     | Welsh    | Gofynnwch i'r arbenigwyr ar bensiynau. Dim jargon. Cyngor cyfeillgar syml. Am ddim |

 Scenario Outline: Visit "<entity>" not within the Pension and Retirement category
    Given I visit "<entity>" not within the Pension and Retirement category in my "<language>"
    Then I should not see the TPAS banner with "<message>"

    Examples:
      | entity   | language | message |
      | article  | English  | Got a pension question? Ask the pension specialists. No jargon. Just friendly guidance. For free |
      | article  | Welsh    | Gofynnwch i'r arbenigwyr ar bensiynau. Dim jargon. Cyngor cyfeillgar syml. Am ddim |
      | category | English  | Got a pension question? Ask the pension specialists. No jargon. Just friendly guidance. For free |
      | category | Welsh    | Gofynnwch i'r arbenigwyr ar bensiynau. Dim jargon. Cyngor cyfeillgar syml. Am ddim |
      | tool     | English  | Got a pension question? Ask the pension specialists. No jargon. Just friendly guidance. For free |
      | tool     | Welsh    | Gofynnwch i'r arbenigwyr ar bensiynau. Dim jargon. Cyngor cyfeillgar syml. Am ddim |

