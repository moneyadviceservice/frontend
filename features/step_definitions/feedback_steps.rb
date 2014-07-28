Given(/^I am viewing an article$/) do
  browse_to_article article('en')
  article_page.page.driver.header('User-Agent', 'agent')
end

Given(/^I am on the article feedback page$/) do
  step 'I am viewing an article'
  step 'I click on the link to give feedback on the article content'
  step 'I should be on the article feedback page'
end

Given(/^I am on the technical feedback page$/) do
  step 'I am viewing an article'
  step 'I click on the link to give technical feedback on the article page'
  step 'I should be on the technical feedback page'
end


Then(/^I should see the feedback panel$/) do
  expect(article_page).to have_feedback_panel
end

Then(/^I should see (?:a|the) link to give feedback on the article content$/) do
  expect(article_page.feedback_panel).to have_article_feedback_link
end

Then(/^I should see (?:a|the) link to give technical feedback on the article page$/) do
  expect(article_page.feedback_panel).to have_technical_feedback_link
end

Then(/^I should see (?:a|the) link to find out how to get financial assistance$/) do
  expect(article_page.feedback_panel).to have_advice_link
end

When(/^I click on the link to give feedback on the article content$/) do
  article_page.feedback_panel.article_feedback_link.click
end

When(/^I click on the link to give technical feedback on the article page$/) do
  article_page.feedback_panel.technical_feedback_link.click
end

When(/^I click on the link to find out how to get financial assistance$/) do
  article_page.feedback_panel.advice_link.click
end

Then(/^I should be on the article feedback page$/) do
  expect(current_page.heading).to have_content(I18n.t('article_feedbacks.new.title'))
end

Then(/^I should be on the technical feedback page$/) do
  expect(current_page.heading).to have_content(I18n.t('technical_feedbacks.new.title'))
end

Then(/^I should be on the advice page$/) do
  expect(current_page.heading).to have_content(I18n.t('advices.show.title'))
end

Given(/^I answer the question on whether the article was useful$/) do
  article_feedback_page.was_page_useful.choose('Yes')
end

Given(/^I provide my suggestions on how to improve the article$/) do
  article_feedback_page.suggestions.set 'A suggestion....'
end

Given(/^I provide the information about what I was trying to do$/) do
  technical_feedback_page.attempting.set 'What I was trying to do....'
end

Given(/^I provide the information about what happened$/) do
  technical_feedback_page.occurred.set 'What happened....'
end

When(/^I submit my article feedback$/) do
  article_feedback_page.submit_button.click
end

When(/^I submit my technical feedback$/) do
  technical_feedback_page.submit_button.click
end

Then(/^I should be back on the original article$/) do
  expect(current_page.heading).to have_content(article.title)
end

Then(/^I should see a confirmation message that my article feedback has been received$/) do
  expect(current_page).to have_content(I18n.t('article_feedbacks.create.flash_notice'))
end

Then(/^I should see a confirmation message that my technical feedback has been received$/) do
  expect(current_page).to have_content(I18n.t('technical_feedbacks.create.flash_notice'))
end

Then(/^the (technical|article) feedback email should have been sent$/) do |type|
  expect(Mail::TestMailer.deliveries.last.subject).to eql "#{type.camelcase} Feedback"
  expect(Mail::TestMailer.deliveries.last.body).to have_content("Url: #{article.url}")
  expect(Mail::TestMailer.deliveries.last.body).to have_content('User Agent: agent')
  expect(Mail::TestMailer.deliveries.last.body).to have_content('Date/Time: ')
end
