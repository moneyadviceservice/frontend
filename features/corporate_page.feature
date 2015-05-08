Feature: Settings
  As a corporate partner
  I want to be able to view more information on partnering
  So that I am aware of different ways of partnering with MAS

  @wip @enable-corporate
  Scenario: Accessing the corporate page
    When  I visit the corporate page
    Then  I should be informed that I am on the correct page

  Scenario: Corporate page is not accessible when feature is disabled
    When I visit the corporate page
    Then  I am told that the functionality is not implemented
