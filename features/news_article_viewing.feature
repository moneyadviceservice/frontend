Feature: View a news article
  As a visitor to the website
  I want to view a news article
  So that I am better informed about that subject

  Scenario Outline: View a news article
    When I view the news article in <language>
    Then I should see the news article in <language>

  Examples:
    | language |
    | English  |
    | Welsh    |

  Scenario Outline: Translate a news article
    Given I view the news article in <original_language>
    When I translate the news article into <translated_language>
    Then I should see the news article in <translated_language>

  Examples:
    | original_language | translated_language |
    | English           | Welsh               |
    | Welsh             | English             |

  Scenario: View news article's publication date
    When I view a news article
    Then I should see its publication date

