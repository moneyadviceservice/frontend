When(/^I view (?:an|the) action plan in (.*)$/) do |language|
  locale = language_to_locale(language)
  data   = { id:          current_action_plan.id,
             title:       current_action_plan.title,
             description: current_action_plan.description,
             body:        current_action_plan.body }
  VCR.use_cassette("action_plan_#{locale}", erb: data) do
    action_plan_page.load(locale: locale, id: current_action_plan.id)
  end
end

When(/^I translate the action plan into (.*)$/) do |language|
  locale = language_to_locale(language)
  current_language = locale_to_language(I18n.locale)
  data = { id:          current_action_plan.id,
           title:       current_action_plan.title,
           description: current_action_plan.description,
           body:        current_action_plan.body }

  expect(action_plan_page.footer_site_links.send("#{language.downcase}_link")[:lang]).to eq(locale)
  expect(article_page.footer_site_links).to_not send("have_#{current_language}_link")

  VCR.use_cassette("action_plan_#{locale}", erb: data) do
    home_page.footer_site_links.send("#{language.downcase}_link").click
  end
end

Then(/^I should see the action plan in (.*)$/) do |language|
  expect(action_plan_page.title).to eq("#{current_action_plan.title} - #{I18n.t('layouts.base.title')}")
  expect(action_plan_page.description[:content]).to include(current_action_plan.description)
  expect(action_plan_page.heading).to have_content(current_action_plan.title)
  expect(action_plan_page.content).to have_content(strip_tags(current_action_plan.body))
end

Then(/^the action plan should have a canonical tag for that language version$/) do
  expected_href = action_plan_url(id: current_action_plan.id, locale: current_locale)

  expect { action_plan_page.canonical_tag[:href] }.to become(expected_href)
end

Then(/^the action plan page should have alternate tags for the supported locales$/) do
  expected_hreflangs = ["en-GB", "cy-GB"]
  expected_hrefs = []
  I18n.available_locales.each { |locale| expected_hrefs << action_plan_url(id: current_action_plan.id, locale: locale) }

  expect(action_plan_page.alternate_tags.size).to eq(expected_hreflangs.size)
  action_plan_page.alternate_tags.each do |alternate_tag|
    expect(expected_hreflangs).to include(alternate_tag[:hreflang])
    expect(expected_hrefs).to include(alternate_tag[:href])
  end
end
