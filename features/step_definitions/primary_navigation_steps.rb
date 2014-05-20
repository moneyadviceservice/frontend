Given 'I am on an article that lives in a single category' do
  instantiate_and_browse_to article_in_single_category
end

Given 'I am on an article that lives in 2 categories in the same parent' do
  instantiate_and_browse_to article_in_two_categories
end

Given 'I am on an article that lives in 2 categories in different parents' do
  instantiate_and_browse_to article_in_two_categories_in_different_parents
end

Then /^I should see the primary navigation with (the parent category|both parent categories) expanded$/ do |num_parent_categories|
  category_nav_categories = article_page.category_nav.categories.map { |c| c.title.text }

  expect(category_nav_categories.count).to eq(all_categories.count)

  all_categories.each do |category|
    expect(category_nav_categories).to include(category['title'])
  end

  parent_categories = if num_parent_categories =~ /both/
    %w{parent-id-1 parent-id-2}
  else
    %w{parent-id-1}
  end

  selected_categories = article_page.category_nav.selected_categories.map do |category|
    category.title.text
  end

  expect(selected_categories.sort).to eq(parent_categories)
end

And /the relevant child categor(y|ies) selected/ do |plural|
  selected_child_categories = []
  article_page.category_nav.selected_categories.each do |category|
    category.selected_categories.each do |child_category|
      selected_child_categories << child_category.text
    end
  end

  expect(selected_child_categories.sort).to eq(current_article['categories'].sort)
end
