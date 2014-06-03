@wip
@vcr
Feature: Article breadcrumbs
  As a user reading an article
  I want to understand where the article belongs
  And be able to quickly navigate to parents so that I can orientate myself

  Scenario: Breadcrumb on an article page
    When I read an article belonging to a single category
    Then I can see breadcrumbs for that category and it's parent

  Scenario: Related categories breadcrumb on an article page
    When I read an article belonging to multiple categories
    Then I can see that it appears in those categories

  @fake-articles
  Scenario: No breadcrumbs are shown for an article that has no parents
    When I read an orphaned article
    Then I should not see breadcrumbs
