Feature: Article SEO
  As a marketeer
  I want our content to include clear meta data
  So that search engines can decide what meets the needs of their customers

  Scenario Outline: Articles include a canonical tag
    Given I view an article in <locale>
    Then the article should have a canonical tag for that language version

  Examples:
    | locale  |
    | English |
    | Welsh   |
