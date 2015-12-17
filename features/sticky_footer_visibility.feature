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

  Scenario Outline: remove visibility from ALL corporate pages
    When I visit a corporate page in "<language>"
    Then I should not see the sticky footer on the corporate page
    Examples:
      | language |
      | English  |
      | Welsh    |

  Scenario Outline: remove visibility from ALL tools pages
    When I visit a tools page in "<language>"
    Then I should not see the sticky footer on the tools page
    Examples:
      | language |
      | English  |
      | Welsh    |

  Scenario Outline: remove visibility from ALL videos pages
    When I visit a videos page in "<language>"
    Then I should not see the sticky footer on the videos page
    Examples:
      | language |
      | English  |
      | Welsh    |

  Scenario: remove visibility from ALL corporate_categories pages
    When I visit a corporate_categories page
    Then I should not see the sticky footer on the corporate_categories page

  Scenario Outline: remove visibility from ALL sitemap pages
    When I visit a sitemap page in "<language>"
    Then I should not see the sticky footer on the sitemap page
    Examples:
      | language |
      | English  |
      | Welsh    |

  Scenario Outline: remove visibility from ALL user account pages
    When I visit an user account page in "<language>"
    Then I should not see the sticky footer on the user account page
    Examples:
      | language |
      | English  |
      | Welsh    |

  Scenario Outline: visibility on articles pages
    When I visit an articles page in "<language>"
    Then I should not see the sticky footer on the article page
    Examples:
      | language |
      | English  |
      | Welsh    |
