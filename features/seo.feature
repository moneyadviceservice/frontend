Feature: Search Engine Optimisation
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

  Scenario Outline: Action Plan pages include a canonical tag
    Given I view an action plan in <locale>
    Then the action plan should have a canonical tag for that language version

  Examples:
    | locale  |
    | English |
    | Welsh   |

  Scenario Outline: Action Plan pages include an alternate tag
    Given I view an action plan in <action_plan_locale>
    Then the action plan should have an alternate tag for the <alternate_locale> version

  Examples:
    | action_plan_locale | alternate_locale |
    | English            | Welsh            |
    | Welsh              | English          |

  Scenario Outline: Article pages include a canonical tag
    Given I view an article in <locale>
    Then the article should have a canonical tag for that language version

  Examples:
    | locale  |
    | English |
    | Welsh   |

  Scenario Outline: Article pages include an alternate tag
    Given I view an article in <article_locale>
    Then the article should have an alternate tag for the <alternate_locale> version

  Examples:
    | article_locale | alternate_locale |
    | English        | Welsh            |
    | Welsh          | English          |
