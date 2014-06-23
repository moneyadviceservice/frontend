When(/^I view (?:a|an|the) article in (.*)$/) do |language|
  browse_to_article article(language)
end

When(/^I translate an article into (.*)$/) do |language|
  locale           = language_to_locale(language)
  current_language = locale_to_language(I18n.locale)

  expect(article_page.footer_site_links.send("#{language.downcase}_link")[:lang]).to eq(locale)
  expect(article_page.footer_site_links).to_not send("have_#{current_language}_link")

  home_page.footer_site_links.send("#{language.downcase}_link").click
end

Then(/^I should see an article in (.*)$/) do |language|
  article = article(language)

  body_text           = Nokogiri::HTML(article.body).inner_html
  sample_of_body_text = strip_tags(body_text).split(/\./)[0]

  expect(article_page.title).to eq("#{article.title} - #{I18n.t('layouts.base.title')}")
  expect(article_page.description[:content]).to include(article.description)
  expect(article_page.heading).to have_content(article.title)
  expect(article_page.content).to have_content(strip_tags(sample_of_body_text))
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
