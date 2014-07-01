Feature: View news index
  As a visitor to the website
  I want to see a selection of news
  So that I can select an article to read easily

  Scenario Outline: User sees a list of news
    When I visit the news page in <language>
    Then I see a list of news in <language>

  Examples:
    | language |
    | English  |
    | Welsh    |

  Scenario: Browsing paginated results
    When I visit the news page
    And I have two pages of results
    Then I should see the 'Older' button
    And I should not see the 'Newer' button
    When I go to the next page of results
    Then I should see what page of results I am on
    And I should not see the 'Older' button
    And I should see the 'Newer' button
