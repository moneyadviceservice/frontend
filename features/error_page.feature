Feature: Friendly Error Message
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

  Scenario Outline: Application throws error with HTML 404 Status Code
    Given that I visit a non-existent page in my "<language>"
    Then I should get a page not found error with this "<status_code>"

    @allow_rescue
    Examples:
      | language | status_code |
      | English  | 404         |
      | Welsh    | 404         |
