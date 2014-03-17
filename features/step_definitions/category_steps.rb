When(/^I view a category containing no child categories$/) do
  step 'I view a category containing no child categories in English'
end

When(/^I view a category containing no child categories in (.*)$/) do |language|
  locale = language_to_locale(language)
  populate_category_repository_with(category_containing_no_child_categories)
  browse_to_category(category_containing_no_child_categories, locale)
end

When(/^I view a category containing child categories$/) do
  step 'I view a category containing child categories in English'
end

When(/^I view a category containing child categories in (.*)$/) do |language|
  locale = language_to_locale(language)
  populate_category_repository_with(category_containing_child_categories)
  browse_to_category(category_containing_child_categories, locale)
end

When(/^I view a category containing child and grandchild categories$/) do
  step 'I view a category containing child and grandchild categories in English'
end

When(/^I view a category containing child and grandchild categories in (.*)$/) do |language|
  locale = language_to_locale(language)
  populate_category_repository_with(category_containing_child_and_grandchild_categories)
  browse_to_category(category_containing_child_and_grandchild_categories, locale)
end

Then(/^I should see the category name and description$/) do
  expect(category_page.heading).to have_content(current_category['title'])
  expect(category_page.description).to have_content(current_category['description'])
end

Then(/^I should see the category content items$/) do
  items = current_category['contents'].map { |i| i['title'] }

  expect(category_page.items.count).to eq(items.count)

  category_page.items.each do |item|
    expect(items).to include(item.text)
  end
end

Then(/^I should see the child category content items$/) do
  current_category['contents'].each_with_index do |child_category, i|
    content_items = child_category['contents'].map { |i| i['title'] }

    expect(category_page.child_categories[i].items.count).to eq(content_items.count)

    category_page.child_categories[i].items.each do |item|
      expect(content_items).to include(item.text)
    end
  end
end

Then(/^I should see the child categories$/) do
  child_categories = current_category['contents'].map { |c| c['title'] }

  expect(category_page.child_categories.count).to eq(child_categories.count)

  category_page.child_categories.each do |child_category|
    expect(child_categories).to include(child_category.title.text)
  end
end

Then(/^I should see the grandchild categories$/) do
  current_category['contents'].each_with_index do |child_category, i|

    grandchild_categories = child_category['contents'].map { |c| c['title'] }
    expect(category_page.child_categories[i].items.count).to eq(grandchild_categories.count)

    category_page.child_categories[i].items.each do |item|
      expect(grandchild_categories).to include(item.text)
    end
  end
end

Then(/^the category should have a canonical tag for that language version$/) do
  expected_href = category_url(id: current_category['id'], locale: current_locale)

  expect { category_page.canonical_tag[:href] }.to become(expected_href)
end

Then(/^the category should have an alternate tag for the (.*) version$/) do |language|
  locale        = language_to_locale(language)
  expected_href = category_url(id: current_category['id'], locale: locale)

  expect { category_page.alternate_tag[:href] }.to become(expected_href)
  expect { category_page.alternate_tag[:hreflang] }.to become(locale)
end
