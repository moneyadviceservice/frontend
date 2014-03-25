When(/^I view (?:a|an|the) article in (.*)$/) do |language|
  locale = language_to_locale(language)
  data   = { id:          current_article.id,
             title:       current_article.title,
             description: current_article.description,
             body:        current_article.body }

  VCR.use_cassette("article_#{locale}", erb: data) do
    article_page.load(locale: locale, id: current_article.id)
  end
end

When(/^I translate the article into (.*)$/) do |language|
  locale = language_to_locale(language)
  current_language = locale_to_language(I18n.locale)
  data = { id:          current_article.id,
           title:       current_article.title,
           description: current_article.description,
           body:        current_article.body }
  expect(article_page.footer_site_links.send("#{language.downcase}_link")[:lang]).to eq(locale)
  expect(article_page.footer_site_links).to_not send("have_#{current_language}_link")

  VCR.use_cassette("article_#{locale}", erb: data) do
    home_page.footer_site_links.send("#{language.downcase}_link").click
  end
end

Then(/^I should see the article in (?:.*)$/) do
  expect(article_page.title).to eq("#{current_article.title} - #{I18n.t('layouts.base.title')}")
  expect(article_page.description[:content]).to include(current_article.description)
  expect(article_page.heading).to have_content(current_article.title)
  expect(article_page.content).to have_content(strip_tags(current_article.body))
end

Then(/^the article should have a canonical tag for that language version$/) do
  expected_href = article_url(id: current_article.id, locale: current_locale)

  expect { article_page.canonical_tag[:href] }.to become(expected_href)
end

Then(/^the article page should have alternate tags for the supported locales$/) do
  expected_hreflangs = ["en-GB", "cy-GB"]
  expected_hrefs = []
  I18n.available_locales.each { |locale| expected_hrefs << article_url(id: current_article.id, locale: locale) }

  expect(article_page.alternate_tags.size).to eq(expected_hreflangs.size)
  article_page.alternate_tags.each do |alternate_tag|
    expect(expected_hreflangs).to include(alternate_tag[:hreflang])
    expect(expected_hrefs).to include(alternate_tag[:href])
  end
end
