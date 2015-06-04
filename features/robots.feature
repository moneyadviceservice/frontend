Feature: discover robots instructions file

  Scenario: display robots text file
    When I visit the conventional robots link
    Then I should see that Atomz is blocked from scrawling
