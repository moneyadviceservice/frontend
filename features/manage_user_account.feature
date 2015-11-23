Feature: update account details
  As a user
  I want to be able update my own information

  Background:
    Given a registered MAS user

  Scenario Outline: edit contact number
    Given that I am on the user account edit settings page in "<language>"
    When I fill in the contact number
    Then I should be able to update my user account

    Examples:
      | language |
      | English  |
      | Welsh    |


  Scenario Outline: edit research preference
    Given that I am on the user account edit settings page in "<language>"
    When I check the research preference box
    Then I should be able to update my user account

    Examples:
      | language |
      | English  |
      | Welsh    |
