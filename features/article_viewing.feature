@wip
Feature: View an article
  As a visitor to the website
  I want to view articles
  So that I can gain understanding about their subject matter

  Scenario Outline: View an article
    When I view an article in <language>
    Then I should see an article in <language>

  Examples:
    | language |
    | English  |
    | Welsh    |

  Scenario Outline: Translate an article
    Given I view an article in <original_language>
    When I translate an article into <translated_language>
    Then I should see an article in <translated_language>

  Examples:
    | original_language | translated_language |
    | English           | Welsh               |
    | Welsh             | English             |
