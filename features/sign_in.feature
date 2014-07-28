Feature: Sign in
  As a registered MAS user
  I want to sign in
  So that I get better financial tools and advice

Scenario: User can't sign in when the feature is disabled
  When I attempt to sign in
  Then I am directed to the old website

@enable-sign-in @pending
Scenario: Sign in
  When I sign in
  Then I should be signed in
  And  I should be at the page I was on
  And  I should receive a "signed in" notification

@enable-sign-in @pending
Scenario: Sign in from a direct link
  When I sign in from a direct link
  Then I should be at the home page

@enable-sign-in @pending
Scenario: Attempt to sign in with invalid details
  When I attempt to sign in with invalid credentials
  Then I should remain signed out
  And  I should receive a "bad credentials" validation message

@enable-sign-in @pending
Scenario: Sign in elsewhere
  Given I am signed in
  When  I sign in elsewhere
  Then  I should be signed in in both places

