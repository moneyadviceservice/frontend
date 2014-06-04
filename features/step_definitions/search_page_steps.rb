When(/^I search for something relevant$/) do
  home_page.search_box.input.set 'health'
  home_page.search_box.submit.click
end

When(/^I search for something irrelevant$/) do
  home_page.search_box.input.set 'tiger'
  home_page.search_box.submit.click
end

When(/^I search for a query that returns two pages of results$/) do
  home_page.search_box.input.set '"When to use an insurance broker"'
  home_page.search_box.submit.click
end

When(/^I submit a search with no query$/) do
  home_page.search_box.input.set ''
  home_page.search_box.submit.click
end

Then(/^I should see the search box$/) do
  expect(home_page).to have_search_box
end

Then(/^I should see the search page$/) do
  expected_heading = ""
  expected_title   = '%s - %s' % [I18n.t('search_results.index.document_title'),
                                  I18n.t('layouts.base.title')]

  expect(search_results_page.title).to eq(expected_title)
  expect(search_results_page.heading).to have_content(expected_heading)
end

Then(/^I should see search results$/) do
  expected_heading = I18n.t('search_results.index_with_results.page_title', query: 'health')
  expected_title   = '%s - %s' % [I18n.t('search_results.index_with_results.document_title', query: 'health'),
                                  I18n.t('layouts.base.title')]

  expect(search_results_page.title).to eq(expected_title)
  expect(search_results_page.heading).to have_content(expected_heading)
  expect(search_results_page).to have_results
end

Then(/^I should see no search results$/) do
  expected_heading = I18n.t('search_results.index_no_results.page_title', query: 'tiger')
  expected_title   = '%s - %s' % [I18n.t('search_results.index_no_results.document_title', query: 'tiger'),
                                  I18n.t('layouts.base.title')]

  expect(search_results_page.title).to eq(expected_title)
  expect(search_results_page.heading).to have_content(expected_heading)
  expect(search_results_page).to have_no_results
end

Then(/^I should prompted to try another search term$/) do
  expect(search_results_page).to have_content(I18n.t('search_results.index_no_results.body'))
end

Then(/^the search results page should have a robots tag with value noindex$/) do
  expect { search_results_page.robots_tag[:content] }.to become('noindex')
end

Then(/^I should see what page of results I am on$/) do
  expect(search_results_page.pagination).to have_page_info
end

Then(/^I should see the "Next" button$/) do
  expect(search_results_page.pagination).to have_next_button
end

Then(/^I should not see the "Next" button$/) do
  expect(search_results_page.pagination).to_not have_next_button
end

Then(/^I should see the "Prev" button$/) do
  expect(search_results_page.pagination).to have_previous_button
end

Then(/^I should not see the "Prev" button$/) do
  expect(search_results_page.pagination).to_not have_previous_button
end

When(/^I go to the next page of results$/) do
  search_results_page.pagination.next_button.click
end

When(/^I go to the fourth page of a query that returns three pages of results$/) do
  visit(search_results_path(locale: I18n.locale, query: '"Health+insurance"', page: 4))
end

Then(/^I should be on page (\d+) of (\d+) of the search results$/) do |page, number_of_pages|
  expect(search_results_page.pagination).to have_content "Page #{page} of #{number_of_pages}"
end
