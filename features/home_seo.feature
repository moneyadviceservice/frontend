Feature: Home SEO
  As a marketeer
  I want our content to include clear meta data
  So that search engines can decide what meets the needs of their customers

  Scenario Outline: Home page include a canonical tag
  Given I view the home page in <locale>
  Then the home page should have a canonical tag for that language version

  Examples:
    | locale  |
    | English |
    | Welsh   |

  Scenario Outline: Home page include an alternate tag
    Given I view the home page in <article_locale>
    Then the home page should have an alternate tag for the <alternate_locale> version

  Examples:
    | article_locale | alternate_locale |
    | English        | Welsh            |
    | Welsh          | English          |
