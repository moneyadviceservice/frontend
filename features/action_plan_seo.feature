Feature: Action Plan SEO
  As a marketeer
  I want our content to include clear meta data
  So that search engines can decide what meets the needs of their customers

  Scenario Outline: Action Plan include a canonical tag
    Given I view an action plan in <locale>
    Then the action plan should have a canonical tag for that language version

  Examples:
    | locale  |
    | English |
    | Welsh   |

   Scenario Outline: Action Plan include an alternate tag
    Given I view an action plan in <action_plan_locale>
    Then the action plan should have an alternate tag for the <alternate_locale> version

  Examples:
    | action_plan_locale | alternate_locale |
    | English            | Welsh            |
    | Welsh              | English          |
