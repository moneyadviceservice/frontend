Feature: Registration
  As a visitor to the website
  I want to register for a MAS account
  So that I can sign in and get better financial tools and advice

  Scenario: Registration when browsing MAS
    Given I am on an article that lives in a single category
    When  I register
    Then  My MAS account should be created
    And   I should be signed in
    And   I should see an "Welcome! You have signed up successfully." notification
    And   I should be at the page I was on

  Scenario: Registration from a direct link
    When I register from a direct link
    Then I should be at the home page

  Scenario Outline: Attempt to register with bad details
    When I attempt to register with <Problem>
    Then My MAS account should not be created
    And  I should remain signed out
    And  I should receive a <Problem> validation error

    Examples:
      | Problem                                       |
      | invalid email                                 |
      | insecure password                             |

  Scenario: Attempt to register with existing account
    When I attempt to register with an already registered email address
    Then My MAS account should have already been created
    Then I should remain signed out
    And  I should receive an already registered email address validation error

  Scenario: Displaying sign up benefits when no session is set
    When I visit the registration page
    Then I should see the registration benefits

  Scenario: Displaying sign up benefits when session is set
    Given I have a registration title set in the session
    When I visit the registration page
    Then I should not see the registration benefits
