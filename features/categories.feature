Feature: Categories
  As a MAS customer
  I want to be able to easily view the contents of categories
  So that I can browse and read content relevant to me

  Scenario: User views a top-level category
    When I view a category containing 2 levels of subcategories
    Then I should see the category name and description
    And I should see the child categories in order
    And their child categories in order
