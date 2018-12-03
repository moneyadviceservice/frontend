Feature: WhatsApp Chat
  As a user visiting the website
  I want to chat online with an advisor via WhatsApp
  So that I can get money advice

  # Glossary:
  # - Online: We are within the hours that chat is operational
  # - Offline: We are outside the hours that chat is operational
  # - Busy: All advisors are occupied

  # Chat operational hours:
  # - Mon-Fri 8am-6pm
  # - Sat 8am-3pm

  @javascript
  Scenario: Chat is online, advisors are available, and the user has JavaScript enabled
    Given chat is online
    And an advisor is available
    Then I should be able to start a chat with an advisor via WhatsApp

  Scenario: Chat is online, advisors are available, and the user has JavaScript disabled
    Given chat is online
    And an advisor is available
    Then I should see a message informing me that I need JavaScript in order chat with an advisor via WhatsApp

  @javascript
  Scenario: Chat is online but all advisors are busy
    Given chat is online
    And all advisors are busy
    Then I should not be able to start a chat with an advisor via WhatsApp
    And I should see a message informing me that WhatsApp chat is currently busy

  @javascript
  Scenario: Chat is offline, but will be online later that day
    Given chat will be next online later today
    Then I should not be able to start a chat with an advisor
    And I should see a message informing me that WhatsApp chat will be online between today's opening hours

  @javascript
  Scenario: Chat is offline and will not be online until tomorrow
    Given chat will be next online tomorrow
    Then I should not be able to start a chat with an advisor
    And I should see a message informing me that WhatsApp chat will be online tomorrow with tomorrow's opening hours

  Scenario: Chat is not supported for Welsh users
    When I visit the website in Welsh
    Then I should see a message informing me that WhatsApp chat is only available in English

  # May not include this one if too complex
  # Scenario: WhatsApp Chat is only displayed on mobile devices
  #   When I visit the website on a desktop device
  #   Then I should not see the WhatsApp chat
