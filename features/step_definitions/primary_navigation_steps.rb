Given 'I am on an article that lives in a single category' do
  browse_to_article article_with_single_parent
end

Then 'I should see the primary navigation with the parent category expanded' do
  category_nav_categories = article_page.category_nav.categories.map { |c| c.title.text }

  expect(category_nav_categories.count).to eq(all_categories.count)

  all_categories.each do |category|
    expect(category_nav_categories).to include(category['title'])
  end

  parent_categories = current_article.parent_categories.map do |id|
    find_category(id)['title']
  end

  selected_categories = article_page.category_nav.selected_categories.map do |category|
    category.title.text
  end

  expect(selected_categories.sort).to eq(parent_categories.sort)
end

And 'the relevant child category selected' do
  selected_child_categories = article_page.category_nav.selected_categories.first.selected_categories

  child_categories = current_article['categories'].map do |id|
    find_category(id)['title']
  end

  expect(selected_child_categories.sort).to eq(child_categories.sort)
end
