Given(/^I read an article belonging to a single category$/) do
  step "I view the article in English"
end

Given(/^I read an article belonging to multiple categories$/) do
  locale = 'en'
  populate_category_repository_with(*multiple_categories_containing_an_article(locale))
  article_page.load(locale: locale, id: article_id_for_locale(locale))
end

Given(/^I read an orphaned article$/) do
  populate_article_repository_with(single_article)
  article_page.load(locale: 'en', id: article_id_for_locale('en'))
end

Then(/^I can see breadcrumbs for that category and it's parent$/) do
  current_article = article_for_locale('en')

  expect(article_page.breadcrumbs).to have_content(I18n.t('layouts.home'))
  expect(article_page.breadcrumbs).to have_content(current_article.categories.first.title)
end

Then(/^I can see that it appears in those categories$/) do
  current_article = article_for_locale('en')
  current_article.categories.each do |category|
    expect(article_page.breadcrumbs).to have_content(category.title)
  end

  expect(article_page.breadcrumbs).to have_content(I18n.t('related_categories.title'))
end

Then(/^I should not see breadcrumbs$/) do
  expect(article_page).to_not have_breadcrumbs
end
