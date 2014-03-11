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
