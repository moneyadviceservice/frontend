Feature: Giving technical feedback on an article
  As a visitor to the website
  When I have feedback to give about an article
  I want to be able to get in touch
  So that I my feedback can be heard

  Scenario: Viewing an article and seeing the technical feedback link
    Given I am viewing an article
    Then I should see a link to give technical feedback on the article page

  Scenario: Giving technical feedback on an article
    Given I am on the technical feedback page
    And I provide the information about what I was trying to do
    And I provide the information about what happened
    When I submit my technical feedback
    Then I should be back on the original article
    And I should see a confirmation message that my technical feedback has been received
    And the technical feedback email should have been sent
