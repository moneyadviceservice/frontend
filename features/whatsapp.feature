@wip
Feature: WhatsApp Chat
  As a user visiting the website
  I want to chat online with an advisor via WhatsApp
  So that I can get money advice

   Glossary:
   - Online: We are within the hours that chat is operational
   - Offline: We are outside the hours that chat is operational
   - Busy: All advisors are occupied

   Chat operational hours:
   - Mon-Fri 8am-6pm
   - Sat 8am-3pm

  Scenario: Chat is online and the button should be visible
    Given chat is online
    When I visit a category with WhatsApp integration in English
    Then I should see a WhatsApp link

  Scenario: Chat is offline, but will be online later that day
    Given chat will be next online later today
    When I visit a category with WhatsApp integration in English
    Then I should see an unavailable message

  Scenario: Chat is offline and will not be online until tomorrow
    Given chat will be next online tomorrow
    When I visit a category with WhatsApp integration in English
    Then I should see an unavailable message

  Scenario: Chat is not supported for Welsh users
    When I visit a category with WhatsApp integration in Welsh
    Then I should see a message informing me that WhatsApp chat is only available in English
