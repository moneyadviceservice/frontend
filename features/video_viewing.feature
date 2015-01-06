Feature: View a video
  As a visitor to the website
  I want to view video page
  So that I can gain understanding about their subject matter

  Scenario Outline: View a video
    When I view a video in <language>
    Then I should see a video in <language>

  Examples:
    | language |
    | English  |
    | Welsh    |
