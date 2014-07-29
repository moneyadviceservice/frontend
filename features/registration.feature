Feature: Registration
  As a visitor to the website
  I want to register for a MAS account
  So that I can sign in and get better financial tools and advice

Scenario: Registering disabled
  When  I attempt to register
  Then  I am told that the functionality is not implemented

@enable-registration @pending
Scenario: Registration
  When  I register
  Then  My MAS account should be created
  And   I should be signed in
  And   I should see an "account created" notification
  And   I should be at the page I was on

@enable-registration @pending
Scenario: Registration from a direct link
  When I register from a direct link
  Then I should be at the home page

@enable-registration @pending
Scenario Outline: Attempt to register with bad details
  When I attempt to register with <Problem>
  Then No MAS account should be created
  And  I should remain signed out
  And  I should receive a "<Problem>" validation error

  Examples:
    | Problem                                       |
    | badly formatted inputs                        |
    | an already registered email address           |
    | different password and password confirmations |
    | unaccepted terms & conditions                 |
    | insecure password                             |
