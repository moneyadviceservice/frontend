@javascript
Feature: Want to Talk
  As user
  I want to talk to someone
  So that I can get bespoke advice

  Scenario: When enabled
    When I view an article in English
    And  the want to talk feature is enabled
    Then I see the want to talk panel in the sidebar

  Scenario: Click to open
    When I view an article in English
    And  the want to talk feature is enabled
    And  I click the want to talk button
    Then I see the expanded want to talk panel
    And  It sends a GA event - TriagePhase1 Open

  Scenario: Click to close
    When I view an article in English
    And  the want to talk feature is enabled
    And  the want to talk panel is open
    And  I click the want to talk button
    Then I don't see the expanded want to talk panel
    And  It sends a GA event - TriagePhase1 Close

  Scenario: When disabled
    When I view an article in English
    Then I don't see the want to talk panel in the sidebar

  Scenario: Scrolling
    When I view an article in English
    And  the want to talk feature is enabled
    And  I scroll down the page
    Then the want to talk panel remains in the viewport

  Scenario: Mobile
    When  I view an article in English
    And   I am on mobile
    And   the want to talk feature is enabled
    Then  I see want to talk panel inline

  Scenario: Click to telephone
    When I view an article in English
    And  the want to talk feature is enabled
    And  the want to talk panel is open
    And  I click the phone number
    Then  It sends a GA event - TriagePhase1 PhoneNumber
