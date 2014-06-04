Given(/^I read an article belonging to a single category$/) do
  browse_to_article article
end

Given(/^I read an article belonging to multiple categories$/) do
  browse_to_article article_with_multiple_parents
end

Given(/^I read an orphaned article$/) do
  browse_to_article orphan_article
end

Then(/^I can see breadcrumbs for that category and it's parent$/) do
  expect(article_page.breadcrumbs).to have_content(current_article.context)
end

Then(/^I can see that it appears in those categories$/) do
  expect(article_page.breadcrumbs).to have_content(current_article.context)
end

Then(/^I should not see breadcrumbs$/) do
  expect(article_page).to_not have_breadcrumbs
end
