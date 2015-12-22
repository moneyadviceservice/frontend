Feature: show the survive January campaign in the article page
  Provides an easy access to helpful information

  Scenario: inactive campaign period
    When I visit an article page before "28th December 2015"
    Then I should not see the Survive January campaign banner

  Scenario Outline: active campaign period
    When I visit an article page on an active campaign "<date>"
    Then I should see the Survive January campaign banner
    Examples:
      | date               |
      | 28th December 2015 |
      | 10th January 2016  |
