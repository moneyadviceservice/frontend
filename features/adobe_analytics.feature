Feature: Adobe Analytics Data Layer
  As an analyst
  I want to see Adobe analytics
  So that I can report on KPIs

@javascript
Scenario: Viewing the data layer on the car cost calculator
  When I view the car cost calculator
  Then I see the correct data layer fields

@javascript
Scenario: Viewing the data layer on WPCC
  When I view the WPCC
  And I complete the first step
  Then I see the correct data layer fields for WPCC

