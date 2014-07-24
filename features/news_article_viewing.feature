Feature: View a news article
  As a visitor to the website
  I want to view a news article
  So that I am better informed about that subject

  Scenario Outline: View a news article
    When I view a news article in <language>
    Then I should see a news article in <language>
    And I should see the latest news in <language>

  Examples:
    | language |
    | English  |
    | Welsh    |

  Scenario Outline: Translate a news article
    Given I view a news article in <original_language>
    When I translate a news article into <translated_language>
    Then I should see a news article in <translated_language>

  Examples:
    | original_language | translated_language |
    | English           | Welsh               |
    | Welsh             | English             |

