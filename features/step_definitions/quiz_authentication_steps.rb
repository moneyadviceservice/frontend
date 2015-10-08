Given(/^that I have a quiz admin account$/) do
  Quiz::QuizUser.create(first_name: 'Admin',
                        last_name: 'Admin',
                        email: 'test@test.com',
                        password: 'testsekret')
end

When(/^I sign in to the quiz app$/) do
  quiz_admin_page.load(locale: 'en')
  quiz_admin_page.email.set('test@test.com')
  quiz_admin_page.password.set('testsekret')
  quiz_admin_page.submit.click
end

Then(/^I should be signed in successful on quiz$/) do
  expect(page).to have_text 'Logout'
end
