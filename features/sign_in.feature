Feature: Sign in
  As a registered MAS user
  I want to sign in
  So that I get better financial tools and advice

Scenario: Sign in
  Given I am on an article that lives in a single category
  When I sign in
  Then I should be signed in
  And  I should be at the page I was on
  And  I should receive a "Signed in successfully." notification

Scenario: Sign in from a direct link
  When I sign in
  Then I should be at the home page

Scenario: Attempt to sign in with invalid details
  When I attempt to sign in with invalid credentials
  Then I should remain signed out
  And  I should receive a "Invalid email or password." validation message

Scenario: Sign in elsewhere
  Given I am signed in
  When  I sign in elsewhere
  Then  I should be signed in in both places

Scenario: Sign out
  Given I am signed in
  And   I am on an article that lives in a single category
  When  I sign out
  Then  I should be signed out
  And   I should be at the page I was on
  And   I should receive a "Signed out successfully." notification

