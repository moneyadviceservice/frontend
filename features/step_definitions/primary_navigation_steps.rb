Given 'I am on an article that lives in a single category' do
  browse_to_article article_with_single_parent
end

Given 'I am on an article that lives in 2 categories in the same parent' do
  browse_to_article article_with_two_child_and_one_parent_category
end

Given 'I am on an article that lives in 2 categories in different parents' do
  browse_to_article article_with_multiple_parents
end

Then /^I should see the primary navigation with (the parent category|both parent categories) expanded$/ do |num_parent_categories|
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

And /the relevant child categor(y|ies) selected/ do |plural|
  selected_child_categories = []
  article_page.category_nav.selected_categories.each do |category|
    category.selected_categories.each do |child_category|
      selected_child_categories << child_category.text
    end
  end

  child_categories = current_article['categories'].map do |id|
    find_category(id)['title']
  end

  expect(selected_child_categories.sort).to eq(child_categories.sort)
end
