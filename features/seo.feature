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

  Scenario Outline: Home page include an alternate tags for all supported languages
    Given I view the home page in <article_locale>
    Then the home page should have alternate tags for the supported locales

  Examples:
    | article_locale |
    | English        |
    | Welsh          |

  Scenario Outline: Home page include a description tag
    Given I view the home page in <locale>
    Then the home page should have a description tag for that language version

  Examples:
    | locale  |
    | English |
    | Welsh   |

  Scenario Outline: Action Plan pages include a canonical tag
    Given I view an action plan in <locale>
    Then the action plan should have a canonical tag for that language version

  Examples:
    | locale  |
    | English |
    | Welsh   |

  Scenario Outline: Action Plan pages include an alternate tags for supported languages
    Given I view an action plan in <action_plan_locale>
    Then the action plan page should have alternate tags for the supported locales

  Examples:
    | action_plan_locale |
    | English            |
    | Welsh              |

  Scenario Outline: Article pages include a canonical tag
    Given I view an article in <locale>
    Then the article should have a canonical tag for that language version

  Examples:
    | locale  |
    | English |
    | Welsh   |

  Scenario Outline: Article pages include an alternate tag
    Given I view an article in <article_locale>
    Then the article page should have alternate tags for the supported locales

  Examples:
    | article_locale |
    | English        |
    | Welsh          |

  Scenario Outline: Category pages include a canonical tag
  Given I view a category containing no child categories in <locale>
  Then the category should have a canonical tag for that language version

  Examples:
    | locale  |
    | English |
    | Welsh   |

  Scenario Outline: Category pages include an alternate tag
    Given I view a category containing no child categories in <category_locale>
    Then the category page should have alternate tags for the supported locales

  Examples:
    | category_locale |
    | English         |
    | Welsh           |

  Scenario: Empty query search results page include a robots tag
    Given I am on the home page
    When I submit a search with no query
    Then the search results page should have a robots tag with value noindex

  Scenario: No results search page include a robots tag
    Given I am on the home page
    When I search for something irrelevant
    Then the search results page should have a robots tag with value noindex

  Scenario: Results search page include a robots tag
    Given I am on the home page
    When I search for something relevant
    Then the search results page should have a robots tag with value noindex

