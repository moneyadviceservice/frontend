When(/^I view a category page$/) do
  category_page.load(locale: :en, id: current_category['id'])
end

Then(/^I should see the category name and description$/) do
  expect(category_page.heading).to have_content(current_category['title'])
  expect(category_page.description).to have_content(current_category['description'])
end

Then(/^I should see the child categories in order$/) do
  subcategories = current_category['contents']

  category_page.sub_categories.each_with_index do |subcategory, i|
    expect(subcategory.title.text).to eq(subcategories[i]['title'])
  end
end

Then(/^their child categories in order$/) do
  subcategories = current_category['contents']

  category_page.sub_categories.each_with_index do |subcategory, i|
    subcategory.subcategories.each_with_index do |subsubcategory, j|
      expect(subsubcategory.text).to eq(subcategories[i]['contents'][j]['title'])
    end
  end
end
