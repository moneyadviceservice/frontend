Given (/^I am on an (article|action_plan) that lives in a single category$/) do |entity|
  fixture = send("#{entity}_with_single_parent")
  send("browse_to_#{entity}", fixture)
end

Given (/^I am on an (article|action_plan) that lives in 2 categories in the same parent$/) do |entity|
  fixture = send("#{entity}_with_two_child_and_one_parent_category")
  send("browse_to_#{entity}", fixture)
end

Given (/^I am on an (article|action_plan) that lives in 2 categories in different parents$/) do |entity|
  fixture = send("#{entity}_with_multiple_parents")
  send("browse_to_#{entity}", fixture)
end

Then (/^I should see the (article|action_plan)'s primary navigation with (the parent category|both parent categories) expanded$/) do |entity, num_parent_categories|
  entity_page = send("#{entity}_page")
  current_entity = send("current_#{entity}")

  category_nav_categories = entity_page.category_nav.categories.map { |c| c.title.text }

  expect(category_nav_categories.count).to eq(all_categories.count)

  all_categories.each do |category|
    expect(category_nav_categories).to include(category['title'])
  end

  parent_categories = current_entity.parent_categories.map do |id|
    find_category(id)['title']
  end

  selected_categories = entity_page.category_nav.selected_categories.map do |category|
    category.title.text
  end

  expect(selected_categories.sort).to eq(parent_categories.sort)
end

And (/^the relevant (article|action_plan)'s child categor(y|ies) selected$/) do |entity, plural|
  entity_page = send("#{entity}_page")
  current_entity = send("current_#{entity}")

  selected_child_categories = []
  entity_page.category_nav.selected_categories.each do |category|
    category.selected_categories.each do |child_category|
      selected_child_categories << child_category.text
    end
  end

  child_categories = current_entity['categories'].map do |id|
    find_category(id)['title']
  end

  expect(selected_child_categories.sort).to eq(child_categories.sort)
end
