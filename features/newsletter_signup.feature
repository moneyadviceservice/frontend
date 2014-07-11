Feature: Newsletter sign up
  As a user visiting the website
  I want to sign up to the newsletter
  So that I can receive free money advice emails

  Background:
    Given The newsletter subscription feature is enabled

  Scenario: View newsletter sign up
    When I visit the website
    Then I should see a newsletter sign up form

  @with_and_without_javascript
  Scenario: Sign up with a valid email address
    When I visit the website
    And I sign up to the newsletter with a valid email address
    Then I should see a message that my subscription was successful

  @with_and_without_javascript
  Scenario: Sign up with an invalid email address
    When I visit the website
    And I sign up to the newsletter with an invalid email address
    Then I should see an error message describing why my subscription failed

  @with_and_without_javascript
  Scenario: Sign up with an existing email address
    When I have already signed up for the newsletter
    And I sign up to the newsletter again with the same email address
    Then I should see a message that my subscription was successful
