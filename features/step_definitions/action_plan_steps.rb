def language_to_locale(language)
  { english: 'en', welsh: 'cy' }[language.downcase.to_sym]
end

When(/^I view the action plan in (.*)$/) do |language|
  data = { id:          current_action_plan.id,
           title:       current_action_plan.title,
           description: current_action_plan.description,
           body:        current_action_plan.body,
           locale:      language_to_locale(language) }

  VCR.use_cassette("action_plan", erb: data) do
    action_plan_page.load(locale: language_to_locale(language), id: current_action_plan.id)
  end
end

Then(/^I should see the action plan in (.*)$/) do |language|
  expect(action_plan_page.title).to eq("#{current_action_plan.title} - #{I18n.t('layouts.base.title')}")
  expect(action_plan_page.description[:content]).to eq(current_action_plan.description)
  expect(action_plan_page.heading).to have_content(current_action_plan.title)
  expect(action_plan_page.content).to have_content(strip_tags(current_action_plan.body))
end
