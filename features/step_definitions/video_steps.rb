When(/^I view a video in (.*)$/) do |language|
  browse_to_video_page(language)
end

Then(/^I should see a video in English$/) do
  expect(video_page.content.text).to match('Get ready for Universal Credit')
end

Then(/^I should see a video in Welsh$/) do
  expect(video_page.content.text).to match('Paratowch at Gredyd Uniongyrchol')
end
