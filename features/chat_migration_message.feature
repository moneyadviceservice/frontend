Feature: show the migration chat message
  As a user visiting the website
  I want to see when chat is inactive outside of the usual opening hours
  So I can decide whether to use an alternative method of contact

  Background:
    Chat will be unavailable for 1 day during migration release

  Scenario: inactive chat period
    When I visit the website on "6th February 2016"
    Then I should see the chat offline migration message

  Scenario Outline: active chat period
    When I visit the website on an active chat "<date>"
    Then I should not see the chat offline migration message
    Examples:
      | date              |
      | 5th February 2016 |
      | 7th February 2016 |
