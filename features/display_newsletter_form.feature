Feature: Display sticky newsletter
  As a CRM manager, I want to serve a sticky footer to MAS customers on mobile and desktop who scroll beyond 50% of the page that they are on.  These are engaged users who are more likely to benefit from - and more likely more favourable to - engagement with MAS.

  Background:
    Given I am on an article page

  Scenario: user subscribes to sticky newsletter
    When user subscribes to receive newsletters
    Then the user should no longer see the newsletter form

  @javascript
  Scenario: dismiss newsletter
    When I dismiss the newsletter
    Then I should not see it again for another month

  @wip @javascript
  Scenario: scroll beyond 50% of the page
    When I scroll to the bottom of the page
    Then I should see a sticky newsletter sign up form
