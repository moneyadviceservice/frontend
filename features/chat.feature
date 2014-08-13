Feature: Chat online
  As a user visiting the website
  I want to chat online with an advisor
  So that I can get money advice

  Glossary:
  - Online: We are within the hours that chat is operational
  - Offline: We are outside the hours that chat is operational
  - Busy: All advisors are occupied

  Chat operational hours:
  - Mon-Fri 8am-10pm
  - Sat 9am-10pm
  - Sun 10am-10pm

  @enable-chat @pending @javascript
  Scenario: Chat is online, advisors are available, and the user has JavaScript enabled
    Given chat is online
    And an advisor is available
    Then I should be able to start a chat with an advisor

  @enable-chat @pending
  Scenario: Chat is online, advisors are available, and the user has JavaScript disabled
    Given chat is online
    And an advisor is available
    Then I should see a message informing me that I need JavaScript in order chat with an advisor

  @enable-chat @pending
  Scenario: Chat is online but all advisors are busy
    Given chat is online
    And all advisors are busy
    Then I should not be able to start a chat with an advisor
    And I should see a message informing me that chat is currently busy

  @enable-chat @pending
  Scenario: Chat is offline, but will be online later that day
    Given chat is offline
    When chat will be next online later today
    Then I should not be able to start a chat with an advisor
    And I should see a message informing me that chat will be online between today's opening hours

  @enable-chat @pending
  Scenario: Chat is offline and will not online until tomorrow
    Given chat is offline
    When chat will be next online tomorrow
    Then I should not be able to start a chat with an advisor
    And I should see a message informing me that chat will be online tomorrow with tomorrow's opening hours

  @enable-chat
  Scenario: Chat is not supported for Welsh users
    When I visit the website in Welsh
    Then I should not be able to start a chat with an advisor
    And I should see a message informing me that chat is only available in English
