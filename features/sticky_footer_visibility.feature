Feature: Sticky footer visibility
  As a User
  I don't want to see the sticky footer displayed on certain pages

  Scenario Outline: visibility on the homepage
    When I visit the homepage in "<language>"
    Then I should not see the sticky footer on the home page
    Examples:
      | language |
      | English  |
      | Welsh    |

  Scenario Outline: remove visibility from ALL category pages
    When I visit a category page in "<language>"
    Then I should not see the sticky footer on the category page
    Examples:
      | language |
      | English  |
      | Welsh    |
