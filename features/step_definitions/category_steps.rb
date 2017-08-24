When(/^I view a category containing no child categories$/) do
  step 'I view a category containing no child categories in English'
end

When(/^I view a category containing no child categories in (.*)$/) do |language|
  locale = language_to_locale(language)
  browse_to_category(category_containing_no_child_categories, locale)
end

When(/^I view a category containing child categories$/) do
  step 'I view a category containing child categories in English'
end

When(/^I view a category containing child categories in (.*)$/) do |language|
  locale = language_to_locale(language)
  browse_to_category(category_containing_child_categories, locale)
end

When(/^I view a category that does not exist$/) do
  category_page.load(locale: 'en', id: 'nonexistent-category')
end

Then(/^I should see the category name and description$/) do
  expect(category_page.heading).to have_content(current_category.title)
  expect(category_page.description).to have_content(current_category.description)
end

Then(/^I should see the category content items$/) do
  category_titles = current_category.contents.map(&:title)

  expect(category_page.items.count).to eq(category_titles.count)

  category_page.items.each do |item|
    expect(category_titles).to include(item.text)
  end
end

Then(/^I should see the child category content items$/) do
  category_page.child_categories.each do |category|
    child = current_category.contents.find { |c| c.id == category.heading['id'] }

    expect(category.items.map(&:text)).to eq(child.contents.map(&:title))
  end
end

Then(/^I should see the child categories$/) do
  child_categories = current_category.contents.map(&:title)

  expect(category_page.child_categories.count).to eq(child_categories.count)

  category_page.child_categories.each do |child_category|
    expect(child_categories).to include(child_category.title.text)
  end
end

Then(/^the category should have a canonical tag for that language version$/) do
  expected_href = category_url(id: current_category['id'], locale: current_locale)

  expect { category_page.canonical_tag[:href] }.to become(expected_href)
end

Then(/^the category page should have alternate tags for the supported locales$/) do
  expected_hreflangs = ['en-GB', 'cy-GB']
  expected_hrefs     = []
  I18n.available_locales.each { |locale| expected_hrefs << category_url(id: current_category['id'], locale: locale) }

  expect(category_page.alternate_tags.size).to eq(expected_hreflangs.size)
  category_page.alternate_tags.each do |alternate_tag|
    expect(expected_hreflangs).to include(alternate_tag[:hreflang])
    expect(expected_hrefs).to include(alternate_tag[:href])
  end
end

Then(/^I should see a 404 error$/) do
  expect(page.status_code).to eq(404)
end
