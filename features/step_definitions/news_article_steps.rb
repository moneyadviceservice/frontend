When(/^I view a news article in (.*)$/) do |language|
  browse_to_news_article(news_article(language))
end

When(/^I translate a news article into (.*)$/) do |language|
  locale           = language_to_locale(language)
  current_language = locale_to_language(I18n.locale)

  expect(news_article_page.footer_secondary.send("#{language.downcase}_link")[:lang]).to eq(locale)
  expect(news_article_page.footer_secondary).to_not send("have_#{current_language}_link")

  home_page.footer_secondary.send("#{language.downcase}_link").click
end

Then(/^I should see a news article in (.*)$/) do |language|
  news_article = news_article(language)

  expect(news_article_page.title).to eq("#{news_article.title} - #{I18n.t('layouts.base.title')}")
  expect(news_article_page.heading).to have_content(news_article.title)
  expect(news_article_page.content).to have_content(news_article.sample_of_body)
  expect(news_article_page.date).to have_content(news_article.formatted_date)
end

Then(/^I should see the latest news in (.+)$/) do |language|
  article_titles = news(language).map(&:title)

  expect(news_article_page.latest_news.count).to eq(6)

  news_article_page.latest_news.each do |article|
    expect(article_titles).to include(article.text)
  end
end
