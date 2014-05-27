@vcr
Feature: Breadcrumbs
  As a user reading an article
  I want to understand where the article belongs
  And be able to quickly navigate to parents so that I can orientate myself

  Scenario Outline: Breadcrumb on an article page
    Given I am on an <language> Article that live on a single Category
    Then I should see the <language> article's category hierarchy

    Examples:
    | language |
    | English  |
    | Welsh    |

  Scenario Outline: Related categories breadcrumb on an article page
    Given I am on an <language> Article that lives in multiple Categories
    Then I should see the realted categories in <language>

    Examples:
    | language |
    | English  |
    | Welsh    |

  Scenario: Remove breadcrumb for articles without categories
    Given I am on an Article that does not belong to any category
    Then I should not see the breadcrumbs area
