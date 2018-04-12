When('I search the query {string}') do |query|
  home_page.search_box.input.set(query)
  home_page.search_box.submit.click
end

When('I go to the next results page') do
  search_results_page.pagination.next_button.click
end

When(
  'I go to results page {string} of the {string} search query'
) do |page, query|
  visit("/en/search?query=#{query}&page=#{page}")
end

When('I should not see the next button') do
  expect(search_results_page.pagination).to_not have_next_button
end

When('I go to the previous results page') do
  expect(search_results_page.pagination).to have_previous_button
  search_results_page.pagination.previous_button.click
end

When(/^I search for something irrelevant$/) do
  home_page.search_box.input.set 'tiger'
  home_page.search_box.submit.click
end

When("I submit a search with no query") do
  home_page.search_box.input.set ''
  home_page.search_box.submit.click
end

When("I go to the last page of results") do
  step %{I go to results page "35" of the "money" search query}
end

Then("the search results page should have a robots tag with value noindex") do
  expect { search_results_page.robots_tag[:content] }.to become('noindex')
end

Then("I should see the search results") do |table|
  results = search_results_page.results.map { |result| result.text }.join("\n")

  table.rows.each do |row|
    expect(results).to include(row[0])
  end
end

When("I search for something relevant") do
  step %{I search the query "money"}
end

Then('I should see no search results for {string}') do |query|
  expected_heading = strip_tags(
    I18n.t('search_results.index_no_results.page_title_html', query: query)
  )

  document_title = I18n.t(
    'search_results.index_no_results.document_title', query: query
  )
  base_title = I18n.t('layouts.base.title')

  expected_title = "#{document_title} - #{base_title}"

  expect(search_results_page.title).to eq(expected_title)
  expect(search_results_page.heading).to have_content(expected_heading)
  expect(search_results_page).to have_no_results
end

Then(
  'I should be on page {string} of {string} of the search results'
) do |page, number_of_pages|
  expect(
    search_results_page.pagination.text
  ).to include("Page #{page} of #{number_of_pages}")
end

Then('I should not see the previous button') do
  expect(search_results_page.pagination).to_not have_previous_button
end

Then('I should see {string} results') do |results_size|
  expect(search_results_page.results.size).to be(results_size.to_i)
end

