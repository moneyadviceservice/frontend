When(/^I visit the news page in (.*)$/) do |language|
  locale = language_to_locale(language)
  news_page.load(locale: locale)
end

Then(/^I see a list of news in (.*)$/) do |language|
  news = news(language)

  expect(news_page.title).to eq("#{I18n.t('news.index.title')} - #{I18n.t('layouts.base.title')}")
  expect(news_page.items_titles.first.text).to eq(news.first_item_title)
  expect(news_page.items_dates.first.text).to eq(news.first_item_date)
  expect(news_page.items_intros.first.text).to eq(news.first_item_intro)
end
