Given 'I am on an article that lives in a single category' do
  article, categories = article_in_single_category

  populate_article_repository_with article
  populate_category_repository_with *categories

  browse_to_article article
end

Then 'I should see the primary navigation with the parent category expanded' do
  category_nav_categories = article_page.category_nav.categories.map { |c| c.title.text }

  expect(category_nav_categories.count).to eq(all_categories.count)

  all_categories.each do |category|
    expect(category_nav_categories).to include(category['title'])
  end

  selected_categories = article_page.category_nav.selected_categories

  expect(selected_categories.count).to eq(1)
  expect(selected_categories.first.title.text).to eq(all_categories.first['title'])
end

And 'the relevant child category selected' do
  selected_child_categories = article_page.category_nav.selected_categories.first.selected_categories

  expect(selected_child_categories.count).to eq(1)
  expect(selected_child_categories.first.text).to eq(all_categories.first['contents'].first['title'])
end
