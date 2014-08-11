Feature: Sign in
  As a registered MAS user
  I want to sign in
  So that I get better financial tools and advice

Scenario: User can't sign in when the feature is disabled
  When I attempt to sign in
  Then I am told that the functionality is not implemented

@enable-sign-in
Scenario: Sign in
  Given I am on an article that lives in a single category
  When I sign in
  Then I should be signed in
  And  I should be at the page I was on
  And  I should receive a "Signed in successfully." notification

@enable-sign-in
Scenario: Sign in from a direct link
  When I sign in
  Then I should be at the home page

@enable-sign-in
Scenario: Attempt to sign in with invalid details
  When I attempt to sign in with invalid credentials
  Then I should remain signed out
  And  I should receive a "Invalid email or password." validation message

@enable-sign-in
Scenario: Sign in elsewhere
  Given I am signed in
  When  I sign in elsewhere
  Then  I should be signed in in both places

@enable-sign-in
Scenario: Sign out
  Given I am signed in
  And   I am on an article that lives in a single category
  When  I sign out
  Then  I should be signed out
  And   I should be at the page I was on
  And   I should receive a "Signed out successfully." notification

