When(/^I visit the Redundancy Advice Tool in "(.*?)"$/) do |language|
  locale = language_to_locale(language)

  case language
  when 'english'
    tools_page.load(locale: locale, id: 'redundancy-pay-calculator')
  when 'welsh'
    tools_page.load(locale: locale, id: 'cyfrifiannell-tal-diswyddo')
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
