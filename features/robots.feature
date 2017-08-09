Feature: discover robots instructions file

  Scenario: display robots text file
    When I visit the conventional robots link
    Then I should see that Atomz is blocked from scrawling
    And I should see that wpcc secret url is blocked from crawlers
