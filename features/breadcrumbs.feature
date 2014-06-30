Feature: Article breadcrumbs
  As a user reading an article
  I want to understand where the article belongs
  And be able to quickly navigate to parents so that I can orientate myself

  Scenario: Breadcrumb on an article page
    When I read an article belonging to a single category
    Then I can see breadcrumbs for the article

  Scenario: Breadcrumb on an action plan page
    When I read an action plan belonging to a single category
    Then I can see breadcrumbs for the action plan

  Scenario: Breadcrumb on a static page
    When I read a static page
    Then I can see breadcrumbs for the static page

 Scenario: Breadcrumb on an category page
    When I read a category
    Then I can see breadcrumbs for the category

  Scenario: Related categories breadcrumb on an article page
    When I read an article belonging to multiple categories
    Then I can see that the article appears in those categories

  Scenario: Related categories breadcrumb on an action plan page
    When I read an action plan belonging to multiple categories
    Then I can see that the action plan appears in those categories

  Scenario: Breadcrumb on an orphaned article page
    When I read an orphaned article
    Then I can see breadcrumbs for the article

  Scenario: Breadcrumb on an orphaned action plan page
    When I read an orphaned action plan
    Then I can see breadcrumbs for the action plan

 Scenario: Breadcrumb on a non-navigational category page
    When I read a non-navigational category
    Then I can see breadcrumbs for the category
