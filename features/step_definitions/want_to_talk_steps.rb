And(/^the want to talk feature is enabled$/) do
  Timeout.timeout(Capybara.default_wait_time) do
    loop do
      begin
        page.evaluate_script('window.masInitWantToTalk()')
        break
      rescue
        retry
      end
    end
  end
end

Then(/^I see the want to talk panel in the sidebar$/) do
  expect(article_page).to have_want_to_talk_side_panel
end

Then(/^I don't see the want to talk panel in the sidebar$/) do
  expect(article_page).not_to have_want_to_talk_side_panel
end

When(/^I click the want to talk button$/) do
  article_page.want_to_talk_side_panel.button.click
end

Then(/^I see the expanded want to talk panel$/) do
  expect(article_page.want_to_talk_side_panel).to be_open
end

When(/^the want to talk panel is open$/) do
  article_page.want_to_talk_side_panel.button.click
end

Then(/^I don't see the expanded want to talk panel$/) do
  expect(article_page.want_to_talk_side_panel).to be_closed
end

Then(/^It sends a GA event - TriagePhase1 Open$/) do
  expect(page).to have_analytics_event({"event"=>"gaEvent", "gaEventCat"=>"TriagePhase1", "gaEventAct"=>"Click", "gaEventLab"=>"Open"})
end

Then(/^It sends a GA event - TriagePhase1 Close$/) do
  expect(page).to have_analytics_event({"event"=>"gaEvent", "gaEventCat"=>"TriagePhase1", "gaEventAct"=>"Click", "gaEventLab"=>"Close"})
end

Then(/^It sends a GA event - TriagePhase1 PhoneNumber$/) do
  expect(page).to have_analytics_event({"event"=>"gaEvent", "gaEventCat"=>"TriagePhase1", "gaEventAct"=>"Click", "gaEventLab"=>"PhoneNumber"})
end

When(/^I click the phone number$/) do
  article_page.want_to_talk_side_panel.phone.click
end

And(/^I scroll down the page$/) do
  article_page.execute_script "window.scrollBy(0,1000)"
end

Then(/^the want to talk panel remains in the viewport$/) do
  expect(article_page.want_to_talk_side_panel).to be_fixed
end

And(/^I am on mobile$/) do
  article_page.page.driver.resize 719, 719
end

Then(/^I see want to talk panel inline$/) do
  expect(article_page).to have_want_to_talk_inline_panel
  expect(article_page).not_to have_want_to_talk_side_panel
end
