@enable-feedback
Feature: Giving feedback on an article
  As a visitor to the website
  When I have feedback to give about an article
  I want to be able to get in touch
  So that I my feedback can be heard

  Scenario: Viewing an article and seeing the feedback options
    Given I am viewing an article
    Then I should see the feedback panel
    And I should see a link to give feedback on the article content
    And I should see a link to give technical feedback on the article page
    And I should see a link to find out how to get financial assistance

  Scenario: Having feedback about the content of an article
    Given I am on the article feedback page
    And I answer the question on whether the article was useful
    And I provide my suggestions on how to improve the article
    When I submit my article feedback
    Then I should be back on the original article
    And I should see a confirmation message that my article feedback has been received
    And the article feedback email should have been sent

  Scenario: Having technical issues with the article
    Given I am on the technical feedback page
    And I provide the information about what I was trying to do
    And I provide the information about what happened
    When I submit my technical feedback
    Then I should be back on the original article
    And I should see a confirmation message that my technical feedback has been received
    And the technical feedback email should have been sent

  Scenario: Having financial issues related to the article
    Given I am viewing an article
    When I click on the link to find out how to get financial assistance
    Then I should be on the advice page
