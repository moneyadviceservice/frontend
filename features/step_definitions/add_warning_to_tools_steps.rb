When(/^I visit a retirement tool "(.*?)" in "(.*?)"$/) do |tool, language|
  locale = language_to_locale(language)

  case tool
  when 'retirement-income-options'
    rio_page.load(locale: locale, tool_name: tool, id: '')
  when 'opsiynau-incwm-ymddeoliad'
    rio_page.load(locale: locale, tool_name: tool, id: '')
  when 'income-drawdown'
    if locale == 'en'
      rio_page.load(locale: locale, tool_name: 'retirement-income-options', id: tool)
    else
      rio_page.load(locale: locale, tool_name: 'opsiynau-incwm-ymddeoliad', id: tool)
    end
  else
    tools_page.load(locale: locale, id: tool)
  end
end

Given (/^Today's date is "(.*?)"$/) do | date |
  Timecop.freeze(Chronic.parse(date))
end

Then(/^I should see the warning about the impending changes in "(.*?)"$/) do |language|
  case language
  when 'english'
    expect(page).to have_content('This tool is currently being updated for the new tax year')
  when 'welsh'
    expect(page).to have_content('Mae’r offeryn hwn yn cael ei ddiweddaru ar hyn o bryd ar gyfer y flwyddyn dreth newydd.')
  end
end

When(/^I visit the Budget Planner in "(.*?)"$/) do |language|
  locale = language_to_locale(language)

  tools_page.load(locale: locale, id: 'budget-planner')
end

Then(/^I should not see the warning about the impending changes in "(.*?)"$/) do |language|
  case language
  when 'english'
    expect(page).to_not have_content('This tool is currently being updated for the new tax year')
  when 'welsh'
    expect(page).to_not have_content('Mae’r offeryn hwn yn cael ei ddiweddaru ar hyn o bryd ar gyfer y flwyddyn dreth newydd.')
  end
end
