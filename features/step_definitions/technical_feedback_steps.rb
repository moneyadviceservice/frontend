Given(/^I am viewing an article$/) do
  browse_to_article article('en')
  article_page.page.driver.header('User-Agent', 'agent')
end

Given(/^I am on the technical feedback page$/) do
  step 'I am viewing an article'
  step 'I click on the link to give technical feedback on the article page'
  step 'I should be on the technical feedback page'
end

Then(/^I should see (?:a|the) link to give technical feedback on the article page$/) do
  expect(article_page).to have_technical_feedback_link
end

When(/^I click on the link to give technical feedback on the article page$/) do
  article_page.technical_feedback_link.click
end

Then(/^I should be on the technical feedback page$/) do
  expect(current_page.heading).to have_content(I18n.t('technical_feedback.new.title'))
end

Given(/^I provide the information about what I was trying to do$/) do
  technical_feedback_page.attempting.set 'What I was trying to do....'
end

Given(/^I provide the information about what happened$/) do
  technical_feedback_page.occurred.set 'What happened....'
end

When(/^I submit my technical feedback$/) do
  technical_feedback_page.submit_button.click
end

Then(/^I should be back on the original article$/) do
  expect(current_page.heading).to have_content(article.title)
end

Then(/^I should see a confirmation message that my technical feedback has been received$/) do
  expect(current_page).to have_content(I18n.t('technical_feedback.create.flash_notice'))
end

Then(/^the technical feedback email should have been sent$/) do
  expect(Mail::TestMailer.deliveries.last.subject).to eql "Technical Feedback"
  expect(Mail::TestMailer.deliveries.last.body).to have_content("Url: #{article.url}")
  expect(Mail::TestMailer.deliveries.last.body).to have_content('User Agent: agent')
  expect(Mail::TestMailer.deliveries.last.body).to have_content('Date/Time: ')
end
