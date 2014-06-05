Feature: Viewing a static page
  As a visitor to the website
  I want to view static pages
  So that I can gain understanding about their subject matter

  Scenario Outline: View a static page
    When I view a static page in <language>
    Then I should see the static page in <language>

  Examples:
    | language |
    | English  |
    | Welsh    |

  Scenario Outline: Translate a static page
    Given I view a static page in <original_language>
    When I translate the static page into <translated_language>
    Then I should see the static page in <translated_language>

  Examples:
    | original_language | translated_language |
    | English           | Welsh               |
    | Welsh             | English             |

  Scenario: View a static page with an intro
    When I view a static page with an intro
    Then I should see the static page's intro on the page
