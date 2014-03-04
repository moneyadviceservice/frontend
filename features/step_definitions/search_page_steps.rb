Then(/^I should see search results$/) do
  search_results_page.has_results?
end

Then(/^I should see no search results$/) do
  search_results_page.has_no_results?
end

Then(/^I should prompted to try another search term$/) do
  search_results_page.has_content? I18n.t('search_results.index.no_results.title')
end

Then(/^I should prompted to try again with a search term$/) do
  search_results_page.has_content? I18n.t('search_results.index.no_query.title')
end
