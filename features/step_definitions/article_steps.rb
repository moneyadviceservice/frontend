When(/^I view (?:a|an|the) article in (.*)$/) do |language|
  locale = language_to_locale(language)
  data   = { id:          current_article.id,
             title:       current_article.title,
             description: current_article.description,
             body:        current_article.body,
             locale:      locale }

  VCR.use_cassette('article', erb: data) do
    article_page.load(locale: locale, id: current_article.id)
  end
end

When(/^I translate the article into (.*)$/) do |language|
  data = { id:          current_article.id,
           title:       current_article.title,
           description: current_article.description,
           body:        current_article.body,
           locale:      language_to_locale(language) }

  expect(article_page.footer_site_links.send("#{language.downcase}_link")[:lang]).
    to eq(language_to_locale(language))

  VCR.use_cassette('article', erb: data) do
    home_page.footer_site_links.send("#{language.downcase}_link").click
  end
end

Then(/^I should see the article in (.*)$/) do |language|
  expect(article_page.title).to eq("#{current_article.title} - #{I18n.t('layouts.base.title')}")
  expect(article_page.description[:content]).to eq(current_article.description)
  expect(article_page.heading).to have_content(current_article.title)
  expect(article_page.content).to have_content(strip_tags(current_article.body))
end

Then(/^the article should have a canonical tag for that language version$/) do
  expected_href = article_url(id: current_article.id, locale: current_locale)

  expect { article_page.canonical_tag[:href] }.to become(expected_href)
end
