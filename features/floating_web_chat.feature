@wip
Feature: Foating Web Chat 
  As a user browsing the MAS home page
  In order to be able to get help quickly
  I would like to see Web chat more accessible and present on desktop when on home page.

Scenario Outline: View Web Chat
  Given I view the home page in <locale>
  When I am within business hours
  Then I should see the floating web chat

  Examples:
    | locale   |
    | English  |
    | Welsh    |

Scenario: floating web chat appears on homepage only; for both EN and CY versions
  Given that I am not on the homepage
  Then I should not see the floating web chat
   
