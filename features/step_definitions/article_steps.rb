When(/^I view (?:a|an|the) article in (.*)$/) do |language|
  browse_to_article article(language)
end

When(/^I translate the article into (.*)$/) do |language|
  locale           = language_to_locale(language)
  current_language = locale_to_language(I18n.locale)

  expect(article_page.footer_site_links.send("#{language.downcase}_link")[:lang]).to eq(locale)
  expect(article_page.footer_site_links).to_not send("have_#{current_language}_link")

  home_page.footer_site_links.send("#{language.downcase}_link").click
end

Then(/^I should see the article in (.*)$/) do |language|
  article = article(language)

  intro_test           = Nokogiri::HTML(article.body).at('p.intro').inner_html
  sample_of_intro_text = strip_tags(intro_test).split(/\./)[0]

  body_text           = Nokogiri::HTML(article.body).at('p:not([class])').inner_html
  sample_of_body_text = strip_tags(body_text).split(/\./)[0]

  expect(article_page.title).to eq("#{article.title} - #{I18n.t('layouts.base.title')}")
  expect(article_page.description[:content]).to include(article.description)
  expect(article_page.heading).to have_content(article.title)
  expect(article_page.intro).to have_content(strip_tags(sample_of_intro_text))
  expect(article_page.main_content).to have_content(strip_tags(sample_of_body_text))
end

Then(/^I should not see the article title in the related content in (.*)$/) do |language|
  article           = article_for_locale(language_to_locale(language))
  decorated_article = ArticleDecorator.decorate(article)

  decorated_article.related_categories.each do |category, contents|
    expect(article_page.related_content).to have_content(category.title)
    contents.each do |item|
      expect(article_page.related_content).to have_content(item.title)
    end
  end
end

Then(/^the article should have a canonical tag for that language version$/) do
  expected_href = article_url(id: current_article.id, locale: current_article.locale)

  expect { article_page.canonical_tag[:href] }.to become(expected_href)
end

Then(/^the article page should have alternate tags for the supported locales$/) do
  expected_hreflangs = %w(en-GB cy-GB)
  expected_hrefs     = I18n.available_locales.map do |locale|
    article_url(id:       article(locale).id,
                locale:   locale,
                protocol: 'https',
                host:     'www.moneyadviceservice.org.uk')
  end

  expect(article_page.alternate_tags.size).to eq(expected_hreflangs.size)

  article_page.alternate_tags.each do |alternate_tag|
    expect(expected_hreflangs).to include(alternate_tag[:hreflang])
    expect(expected_hrefs).to include(alternate_tag[:href])
  end
end
