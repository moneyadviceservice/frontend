Given(/^I read an article belonging to a single category$/) do
  step "I view the article in English"
end

Given(/^I read an article belonging to multiple categories$/) do
  article_page.load(locale: 'en', id: 'changes-to-child-benefit-from-2013')
end

Given(/^I read an orphaned article$/) do
  article_page.load(locale: 'en', id: 'if-your-baby-is-stillborn')
end

Then(/^I can see breadcrumbs for that category and it's parent$/) do
  expect(article_page.breadcrumbs).to have_content('Home > Money topics > Births, deaths and family')
end

Then(/^I can see that it appears in those categories$/) do
  current_article = article_for_locale('en')
  current_article.categories.each do |category|
    expect(article_page.breadcrumbs).to have_content(category.title)
  end

  expect(article_page.breadcrumbs).to have_content(I18n.t('articles.show.related_categories.title'))
end

Then(/^I should not see breadcrumbs$/) do
  expect(article_page).to_not have_breadcrumbs
end
