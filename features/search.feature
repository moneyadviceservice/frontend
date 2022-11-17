@wip
Feature: Searching on MAS site
  As a user visiting the website
  I want to search by keyword
  So that I can find the content I am looking for

  Background:
    Given I am on the home page

  Scenario: Search on first result page
    When I search the query "money"
    Then I should see "10" results
    And I should see the search results
      | title                                             |
      | Money Advice Toolkits                             |
      | Our board                                         |
      | Money lives: Paul                                 |
    And I should be on page "1" of "34" of the search results
    And I should not see the previous button

  Scenario: Search and navigate to the next result page
    When I search the query "money"
    And I go to the next results page
    Then I should see "10" results
    And I should see the search results
      | title                          |
      | Debt advice evaluation toolkit |
    And I should be on page "2" of "34" of the search results

  Scenario: Search and navigate to last result page
    When I search the query "money"
    And I go to the last page of results
    Then I should be on page "34" of "34" of the search results
    And I should see the search results
      | title                                                        |
      | Council Tax: what it is, what it costs and how to save money |
    And I should not see the next button

  Scenario: Search and navigate to a previous result page
    When I search the query "money"
    And I go to the last page of results
    And I go to the previous results page
    Then I should see "10" results
    And I should see the search results
      | title                                                     |
      | UK could gain £108 billion from improved money management |
    And I should be on page "33" of "34" of the search results

  Scenario: Search with no results
    When I search the query "Norris"
    Then I should see no search results for "Norris"
