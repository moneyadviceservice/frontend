Feature: Category page filter
  As a user visiting the website
  I want to be able to refine the content displayed
  so I can find relevant content more easily

  Scenario: View a category page
    When I view a category containing child categories
	Then I should see a filterable list of contents
