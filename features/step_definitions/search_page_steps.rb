When(/^I search for something relevant$/) do
  home_page.search_box.input.set 'health'
  VCR.use_cassette("search_relevant") do
    home_page.search_box.submit.click
  end
end

When(/^I search for something irrelevant$/) do
  home_page.search_box.input.set 'cats'

  VCR.use_cassette("search_irrelevant") do
    home_page.search_box.submit.click
  end
end

When(/^I submit a search with no query$/) do
  home_page.search_box.input.set ''
  home_page.search_box.submit.click
end


Then(/^I should see the search box$/) do
  home_page.should have_search_box
end

Then(/^I should see search results$/) do
  search_results_page.has_results?
end

Then(/^I should see no search results$/) do
  search_results_page.has_no_results?
end

Then(/^I should prompted to try another search term$/) do
  search_results_page.has_content? I18n.t('search_results.index_no_results.body')
end

Then(/^I should prompted to try again with a search term$/) do
  search_results_page.has_content? I18n.t('search_results.index.body')
end

Then(/^the search results page should have a robots tag with value noindex$/) do
  expect { search_results_page.robots_tag[:content] }.to become('noindex')
end
