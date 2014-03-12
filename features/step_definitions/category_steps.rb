When(/^I view a category containing no child categories$/) do
  pending
end

When(/^I view a category containing child categories$/) do
  pending
end

When(/^I view a category containing child and grandchild categories$/) do
  pending
end

Then(/^I should see the category name and description$/) do
  expect(category_page.heading).to have_content(current_category['title'])
  expect(category_page.description).to have_content(current_category['description'])
end

Then(/^I should see the category content items$/) do
  pending
end

Then(/^I should see the child category content items$/) do
  pending
end

Then(/^I should see the child categories$/) do
  pending
end

Then(/^I should see the grandchild categories$/) do
  pending
end

#When(/^I view a category containing 2 levels of subcategories$/) do
#  populate_category_repository_with(category_with_2_levels_of_subcategory)
#  browse_to_category(category_with_2_levels_of_subcategory)
#end
#
#When(/^I view a category containing only content$/) do
#  populate_category_repository_with(category_containing_only_content)
#  browse_to_category(category_containing_only_content)
#end
#
#Then(/^I should see the child categories in order$/) do
#  subcategories = current_category['contents']
#
#  expect(category_page.sub_categories.count).to eq(subcategories.count)
#
#  category_page.sub_categories.each_with_index do |subcategory, i|
#    expect(subcategory.title.text).to eq(subcategories[i]['title'])
#  end
#end
#
#Then(/^their child categories in order$/) do
#  subcategories = current_category['contents']
#
#  category_page.sub_categories.each_with_index do |subcategory, i|
#    subcategory.subcategories.each_with_index do |subsubcategory, j|
#      expect(subsubcategory.text).to eq(subcategories[i]['contents'][j]['title'])
#    end
#  end
#end
#
#Then(/^I should see the content items$/) do
#  items = current_category['contents'].map { |i| i['title'] }
#
#  expect(category_page.content_items.count).to eq(items.count)
#
#  category_page.content_items.each do |item|
#    expect(items).to include(item.text)
#  end
#end
