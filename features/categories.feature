Feature: Categories
  As a MAS customer
  I want to be able to easily view the contents of categories with 2 levels of categories beneath
  So that I can browse and read content relevant to me

  Scenario: User views a category with 2 levels of subcategories
    When I view a category page
    Then I should see the category name and description
    And I should see the child categories in order
    And their child categories in order
