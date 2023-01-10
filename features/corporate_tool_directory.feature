@wip
Feature: Corporate Tool Directory
  As a corporate MAS partner
  I can see the catalog of MAS tools available for syndication
  So I can browse through relevant tools I may want on my site.

  Scenario: Accessing the corporate tool directory page
    When I visit the corporate tool directory page
    Then I should be on the corporate tool directory

  Scenario: Popular tools
    When I visit the corporate tool directory page
    Then I should be presented with the most popular tools

  Scenario: All tools
    When I visit the corporate tool directory page
    Then I should be presented with a list of all tools available
