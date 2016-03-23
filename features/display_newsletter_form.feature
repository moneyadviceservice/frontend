Feature: Display sticky newsletter
  As a CRM manager, I want to serve a sticky footer to MAS customers on mobile and desktop who scroll beyond 50% of the page that they are on.  These are engaged users who are more likely to benefit from - and more likely more favourable to - engagement with MAS.

  Background:
    Given I am on an article page

  Scenario: user subscribes to newsletter via the sticky footer
    When user subscribes to receive newsletters
    Then I should not see the newsletter form

  @javascript
  Scenario: should not see the sticky newsletter footer without scrolling
    Then I should not see the newsletter form

  @javascript
  Scenario: should see the sticky newsletter footer after scrolling down
    When I scroll to the bottom of the page
    And I dismiss the newsletter
    Then I should not see the newsletter form
