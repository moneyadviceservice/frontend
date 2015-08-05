Feature: Display sticky newsletter
  As a CRM manager, I want to serve a sticky footer to MAS customers on mobile and desktop who scroll beyond 50% of the page that they are on.  These are engaged users who are more likely to benefit from - and more likely more favourable to - engagement with MAS.

  Scenario: user signs up for newsletter
    Given an unregistered user visits the MAS site
    When user subscribes to receive newsletters
    Then the user should no longer see the newsletter form

  Scenario: customer dismisses newsletter sign-up form
    Given an unregistered user visits the MAS site
    When the user dismisses the newsletter sign up form
    Then the user should no longer see the newsletter form
