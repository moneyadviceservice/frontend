RSpec.describe ArticlesHelper, '#category_has_more_content?', type: :helper do
  let(:article)                  { double(categories: [category]) }
  let(:category_id)              { 'category-id' }
  let(:category)                 { Core::Category.new(category_id, contents: contents) }
  let(:contents)                 { Array.new(4) { double } }
  let(:related_content_category) { Core::Category.new(category_id, contents: contents) }

  subject { helper.category_has_more_content?(article, related_content_category) }

  context 'when the category has no more content' do
    it { should be_falsey }
  end

  context 'when the article has no categories' do
    let(:article) { double(categories: []) }

    it { should be_falsey }
  end

  context 'when the category has more content' do
    let(:related_content_category) { Core::Category.new(category_id, contents: contents.take(2)) }

    it { should be_truthy }
  end
end
