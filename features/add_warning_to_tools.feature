Feature: Warning About Budget Changes
  In case we are unable to make all of the necessary changes to the redundancy advice tool ahead of Budget, we should have the following warning in place. This warning should be schedulable, and relatively straight-forward to put in place and remove. The same warning will need to be applied to other tools (see #7127) but also may need to be applied to other tools in case there are unforeseen Budget announcements that impact tools.
  The following tool should have the warning if it has not been updated by March 16th. Redundancy Advice Tool - https://www.moneyadviceservice.org.uk/en/tools/redundancy-pay-calculator.

  Scenario Outline: before the budget announcement
    Given Today's date is "3rd March 2016"
    When I visit the Redundancy Advice Tool in "<language>"
    Then I should not see the warning about the impending changes in "<language>"

    Examples:
      | language |
      | english  |
      | welsh    |

  Scenario Outline: on the day of the budget announcement
    Given Today's date is "16th March 2016"
    When I visit the Redundancy Advice Tool in "<language>"
    Then I should see the warning about the impending changes in "<language>"

    Examples:
      | language |
      | english  |
      | welsh    |

  Scenario Outline: after the budget announcement
    Given Today's date is "24th March 2016"
    When I visit the Redundancy Advice Tool in "<language>"
    Then I should see the warning about the impending changes in "<language>"

    Examples:
      | language |
      | english  |
      | welsh    |

   Scenario Outline: banner visibility on non-affected tools
    """
      on the day of the budget announcement, the banner should not show on any tool except Redundancy Advice
    """
    Given Today's date is "16th March 2016"
    When I visit the Budget Planner in "<language>"
    Then I should not see the warning about the impending changes in "<language>"

    Examples:
      | language |
      | english  |
      | welsh    |
