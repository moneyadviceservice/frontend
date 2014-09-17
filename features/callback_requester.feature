Feature: Callback requester
  As a visitor to the website
  When I have read an article
  I want to be able to request a callback
  So that I get further support with my money issues

  Scenario: When feature is disabled
    Given I am viewing an article with callback enabled
    Then  I should not see the callback requester panel

  @enable-callback-requester
  Scenario: When viewing callback disabled article
    Given I am viewing an article with callback disabled
    Then  I should not see the callback requester panel

  @enable-callback-requester
  Scenario: When viewing callback enabled article
    Given I am viewing an article with callback enabled
    Then  I should see the callback requester panel

