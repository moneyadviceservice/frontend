Given(/^I am on an (.*) Article that live on a single Category$/) do |language|
  step "I view the article in #{language}"
end

Given(/^I am on an (.*) Article that lives in multiple Categories$/) do |language|
  locale = language_to_locale(language)
  populate_category_repository_with(*multiple_categories_containing_an_article(locale))
  article_page.load(locale: locale, id: article_id_for_locale(locale))
end

Then(/^I should see the (.*) article's category hierarchy$/) do |language|
  locale = language_to_locale(language)
  current_article = article_for_locale(locale)

  expect(article_page.breadcrumbs).to have_content(I18n.t('layouts.base.home'))
  expect(article_page.breadcrumbs).to have_content(current_article.categories.first.title)
end

Then(/^I should see the realted categories in (.*)$/) do |language|
  locale = language_to_locale(language)
  current_article = article_for_locale(locale)
  current_article.categories.each do |category|
    expect(article_page.breadcrumbs).to have_content(category.title)
  end

  expect(article_page.breadcrumbs).to have_content(I18n.t('related_categories.title'))
end
