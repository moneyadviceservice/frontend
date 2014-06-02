When(/^I view (?:a|an|the) static page in (.*)$/) do |language|
  locale = language_to_locale(language)
  static_page.load(locale: locale, id: static_page_id_for_locale(locale))
end

When(/^I translate (?:a|an|the) static page into (.*)$/) do |language|
  locale = language_to_locale(language)
  current_language = locale_to_language(I18n.locale)

  expect(static_page.footer_site_links.send("#{language.downcase}_link")[:lang]).to eq(locale)
  expect(static_page.footer_site_links).to_not send("have_#{current_language}_link")

  static_page.footer_site_links.send("#{language.downcase}_link").click
end

Then(/^I should see the static page in (.*)$/) do |language|
  current_static_page = static_page_for_locale(language_to_locale(language))

  expect(static_page.title).to eq("#{current_static_page.title} - #{I18n.t('layouts.base.title')}")
  expect(static_page.description[:content]).to include(current_static_page.description)
  expect(static_page.heading).to have_content(current_static_page.title)

  sample_of_body_text = strip_tags(Nokogiri::HTML(current_static_page.body).at('p').inner_html).split(/\./)[0]
  expect(static_page.content).to have_content(strip_tags(sample_of_body_text))
end
