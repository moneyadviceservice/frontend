When(/^I view (?:an|the) action plan in (.*)$/) do |language|
  locale = language_to_locale(language)
  data   = { id:          current_action_plan.id,
             title:       current_action_plan.title,
             description: current_action_plan.description,
             body:        current_action_plan.body,
             locale:      locale }

  VCR.use_cassette('action_plan', erb: data) do
    action_plan_page.load(locale: locale, id: current_action_plan.id)
  end
end

When(/^I translate the action plan into (.*)$/) do |language|
  data = { id:          current_action_plan.id,
           title:       current_action_plan.title,
           description: current_action_plan.description,
           body:        current_action_plan.body,
           locale:      language_to_locale(language) }

  expect(action_plan_page.footer_site_links.send("#{language.downcase}_link")[:lang]).
    to eq(language_to_locale(language))

  VCR.use_cassette('action_plan', erb: data) do
    home_page.footer_site_links.send("#{language.downcase}_link").click
  end
end

Then(/^I should see the action plan in (.*)$/) do |language|
  expect(action_plan_page.title).to eq("#{current_action_plan.title} - #{I18n.t('layouts.base.title')}")
  expect(action_plan_page.description[:content]).to eq(current_action_plan.description)
  expect(action_plan_page.heading).to have_content(current_action_plan.title)
  expect(action_plan_page.content).to have_content(strip_tags(current_action_plan.body))
end

Then(/^the action plan should have a canonical tag for that language version$/) do
  expected_href = action_plan_url(id: current_action_plan.id, locale: current_locale)

  expect { action_plan_page.canonical_tag[:href] }.to become(expected_href)
end
