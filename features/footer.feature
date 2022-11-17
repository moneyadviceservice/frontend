@wip
Feature: Footer
  As an content provider
  I want to be able to show the footer in english and welsh
  In order to be available to contact within the whole nation

  Scenario: Acessing the english site
    Given I am on the home page
    Then I should see the footer
      | text                                                                |
      | Web chat                                                            |
      | Got a question? Our advisers will point you in the right direction. |
      | Monday to Friday, 8am to 8pm                                        |
      | Saturday, 9am to 1pm.                                               |
      | Sunday and Bank Holidays, closed                                    |
      | Contact Us                                                          |
      | Give us a call for free and impartial money advice.                 |
      | 0800 138 7777                                                       |

  Scenario: Acessing the welsh site
    Given I visit the website in Welsh
    Then I should see the footer
      | text                                                                |
      | Gwe-sgwrs                                                           |
      | A oes gennych chi gwestiwn? Bydd ein cynghorwyr yn eich arwain      |
      | Dydd Llun i Dydd Gwener, 8am i 8pm                                  |
      | Dydd Sadwrn, 9am i 1pm                                              |
      | Cysylltwch â ni​​                                                     |
      | Ffoniwch ni am gyngor ariannol am ddim a diduedd.                   |
      | 0800 138 0555                                                       |
      | Mae galwadau am ddim                                                |
