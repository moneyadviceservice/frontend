Feature: Error Page
  As an owner of the MAS website
  I want to present users with friendly error messages
  So that they have a more positive user experience

  Scenario Outline: Application throws error with HTML 500 Status Code
    Given that I visit the internal server error page in my "<language>"
    Then I should get an internal server "<error_message>"

    Examples:
      | language | error_message |
      | English  | This page is currently unavailable, please try reloading |
      | Welsh    | Nid yw'r dudalen hon ar gael ar hyn o bryd, ceisiwch ail-lwytho |
