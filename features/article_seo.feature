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

  Scenario Outline: Articles include an alternate tag
    Given I view an article in <article_locale>
    Then the article should have an alternate tag for the <alternate_locale> version

  Examples:
    | article_locale | alternate_locale |
    | English        | Welsh            |
    | Welsh          | English          |
