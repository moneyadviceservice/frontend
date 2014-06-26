When(/^I view a news article in (.*)$/) do |language|
  browse_to_news_article(news_article(language))
end

Then(/^I should see a news article in (.*)$/) do |language|
  news_article = news_article(language)

  expect(news_article_page.title).to eq("#{news_article.title} - #{I18n.t('layouts.base.title')}")
  expect(news_article_page.heading).to have_content(news_article.title)
  expect(news_article_page.content).to have_content(news_article.sample_of_body)
  expect(news_article_page.date).to have_content(news_article.formatted_date)
end
