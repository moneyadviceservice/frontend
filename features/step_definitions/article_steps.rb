When(/^I view (?:a|an|the) article in (.*)$/) do |language|
  locale = language_to_locale(language)
  article_page.load(locale: locale, id: article_id_for_locale(locale))
end

When(/^I translate the article into (.*)$/) do |language|
  locale = language_to_locale(language)
  current_language = locale_to_language(I18n.locale)

  expect(article_page.footer_site_links.send("#{language.downcase}_link")[:lang]).to eq(locale)
  expect(article_page.footer_site_links).to_not send("have_#{current_language}_link")

  home_page.footer_site_links.send("#{language.downcase}_link").click
end

Then(/^I should see the article in (.*)$/) do |language|
  current_article = article_for_locale(language_to_locale(language))

  expect(article_page.title).to eq("#{current_article.title} - #{I18n.t('layouts.base.title')}")
  expect(article_page.description[:content]).to include(current_article.description)
  expect(article_page.heading).to have_content(current_article.title)

  # Use the first sentence in the body as the string to search for from the body
  sample_of_body_text = strip_tags(Nokogiri::HTML(current_article.body).search('p').inner_html).split(/\./)[0]
  expect(article_page.content).to have_content(strip_tags(sample_of_body_text))
end

Then(/^the article should have a canonical tag for that language version$/) do
  expected_href = article_url(id: article_for_locale(current_locale).id, locale: current_locale)

  expect { article_page.canonical_tag[:href] }.to become(expected_href)
end

Then(/^the article page should have alternate tags for the supported locales$/) do
  expected_hreflangs = ["en-GB", "cy-GB"]
  expected_hrefs = I18n.available_locales.map do |locale|
    article_url(id: article_for_locale(locale.to_s).id, locale: locale, protocol: 'https', host: 'www.moneyadviceservice.org.uk')
  end

  expect(article_page.alternate_tags.size).to eq(expected_hreflangs.size)
  article_page.alternate_tags.each do |alternate_tag|
    expect(expected_hreflangs).to include(alternate_tag[:hreflang])
    expect(expected_hrefs).to include(alternate_tag[:href])
  end
end
