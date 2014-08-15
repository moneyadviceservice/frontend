Feature: Registration
  As a visitor to the website
  I want to register for a MAS account
  So that I can sign in and get better financial tools and advice

Scenario: Registering disabled
  When  I attempt to register
  Then  I am told that the functionality is not implemented

@enable-registration
Scenario: Registration when browsing MAS
  Given I am on an article that lives in a single category
  When  I register
  Then  My MAS account should be created
  And   I should be signed in
  And   I should see an "Welcome! You have signed up successfully." notification
  And   I should be at the page I was on

@enable-registration
Scenario: Registration from a direct link
  When I register from a direct link
  Then I should be at the home page

@enable-registration
Scenario Outline: Attempt to register with bad details
  When I attempt to register with <Problem>
  Then My MAS account should not be created
  And  I should remain signed out
  And  I should receive a <Problem> validation error

  Examples:
    | Problem                                       |
    | invalid email                                 |
    | insecure password                             |

@enable-registration
Scenario: Attempt to register with existing account
  When I attempt to register with an already registered email address
  Then My MAS account should have already been created
  Then I should remain signed out
  And  I should receive an already registered email address validation error

@enable-registration
Scenario: Edit account details
  Given I register
  When I attempt to edit my account
  Then I am told that the functionality is not implemented

