Feature: Quiz Authentication
  In order to ensure that users of the Quiz app can sign in to the mounted quiz without any problems.

  Scenario: Admin login
    Given that I have a quiz admin account
    When I sign in to the quiz app
    Then I should be signed in successful on quiz
