When(/^I view (?:an|the) action plan in (.*)$/) do |language|
  locale = language_to_locale(language)

  action_plan_page.load(locale: locale, id: current_action_plan_in(locale).id)
end

When(/^I translate the action plan into (.*)$/) do |language|
  locale = language_to_locale(language)
  current_language = locale_to_language(I18n.locale)

  expect(action_plan_page.footer_site_links.send("#{language.downcase}_link")[:lang]).to eq(locale)
  expect(article_page.footer_site_links).to_not send("have_#{current_language}_link")

  action_plan_page.footer_site_links.send("#{language.downcase}_link").click
end

Then(/^I should see the action plan in (.*)$/) do |language|
  current_action_plan = current_action_plan_in(language_to_locale(language))

  expect(action_plan_page.title).to eq("#{current_action_plan.title} - #{I18n.t('layouts.base.title')}")
  expect(action_plan_page.description[:content]).to include(current_action_plan.description)
  expect(action_plan_page.heading).to have_content(current_action_plan.title)
  expect(action_plan_page.content).to have_content(strip_tags(current_action_plan.body))
end

Then(/^the action plan should have a canonical tag for that language version$/) do
  expected_href = action_plan_url(id: current_action_plan_in(current_locale).id, locale: current_locale)

  expect { action_plan_page.canonical_tag[:href] }.to become(expected_href)
end

Then(/^the action plan page should have alternate tags for the supported locales$/) do
  expected_hreflangs = ["en-GB", "cy-GB"]
  expected_hrefs = I18n.available_locales.map do |locale|
    action_plan_url(id: current_action_plan_in(locale.to_s).id, locale: locale, protocol: 'https', host: 'www.moneyadviceservice.org.uk')
  end

  expect(action_plan_page.alternate_tags.size).to eq(expected_hreflangs.size)
  action_plan_page.alternate_tags.each do |alternate_tag|
    expect(expected_hreflangs).to include(alternate_tag[:hreflang])
    expect(expected_hrefs).to include(alternate_tag[:href])
  end
end
