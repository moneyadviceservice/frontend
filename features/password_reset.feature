Feature: Reset password
  As a Registered MAS user,
  I want to be able to reset my password
  so that I can access my account.

  Scenario: Forgotten password
    Given I have an account
    And   I attempt to sign in
    When  I click on 'Forgot your password?'
    Then  I should be on a page instructing me of the next steps

  Scenario: Resetting password
      Given I have an account
      And   I attempt to sign in
      When  I click on 'Forgot your password?'
      And   I fill in my email
      Then  I should see an email sent notification
      And   I should receive 1 email
      When  I open the email
      Then  I should see "Change my password" in the email body
      When  I follow "Change my password" in the email
      Then  I should be able to change my password
