When(/^I view the (action plan|article) in (.*)$/) do |editorial_name, language|
  current_id = current_editorial(editorial_name).id
  data = { id:          current_id,
           title:       current_editorial(editorial_name).title,
           description: current_editorial(editorial_name).description,
           body:        current_editorial(editorial_name).body,
           locale:      language_to_locale(language) }

  VCR.use_cassette(underscore(editorial_name), erb: data) do
    editorial_page(editorial_name).load(locale: language_to_locale(language), id: current_id)
  end
end

When(/^I translate the (action plan|article) into (.*)$/) do |editorial_name, language|
  data = { id:          current_editorial(editorial_name).id,
           title:       current_editorial(editorial_name).title,
           description: current_editorial(editorial_name).description,
           body:        current_editorial(editorial_name).body,
           locale:      language_to_locale(language) }

  expect(editorial_page(editorial_name).footer_site_links.send("#{language.downcase}_link")[:lang]).
    to eq(language_to_locale(language))

  VCR.use_cassette(underscore(editorial_name), erb: data) do
    home_page.footer_site_links.send("#{language.downcase}_link").click
  end
end

Then(/^I should see the (action plan|article) in (?:.*)$/) do |editorial_name|
  expect(editorial_page(editorial_name).title).
    to eq("#{current_editorial(editorial_name).title} - #{I18n.t('layouts.base.title')}")

  expect(editorial_page(editorial_name).description[:content]).
    to eq(current_editorial(editorial_name).description)

  expect(editorial_page(editorial_name).heading).
    to have_content(current_editorial(editorial_name).title)

  expect(editorial_page(editorial_name).content).
    to have_content(strip_tags(current_editorial(editorial_name).body))
end
