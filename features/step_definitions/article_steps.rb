When(/^I view an article$/) do
  data = { id:          current_article.id,
           title:       current_article.title,
           description: current_article.description,
           body:        current_article.body }

  VCR.use_cassette('article', erb: data) do
    article_page.load(locale: I18n.locale, id: current_article.id)
  end
end

Then(/^the article should be displayed$/) do
  expect(article_page.title).to eq("#{current_article.title} - Money Advice Service")
  expect(article_page.description[:content]).to eq(current_article.description)
  expect(article_page.heading).to have_content(current_article.title)
  expect(article_page.content).to have_content(strip_tags(current_article.body))
end
