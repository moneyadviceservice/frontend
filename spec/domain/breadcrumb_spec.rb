RSpec.describe Breadcrumb do
  let(:locale)   { :en }
  let(:id)       { 'category-id' }
  let(:title)    { 'category-title' }
  let(:category) { double(id: id, title: title, home?: false, news?: false) }

  subject { described_class.new(category) }

  before do
    allow(I18n).to receive(:locale).and_return(locale)
  end

  specify { expect(subject.title).to eq(title) }
  specify { expect(subject.path).to eq(category_path(category.id, locale: locale)) }

  context 'when the category is a HomeCategory' do
    let(:category) { HomeCategory.new }

    specify { expect(subject.title).to eq(category.title) }
    specify { expect(subject.path).to eq(category.path) }
  end

  context 'when the category is a NewsCategory' do
    let(:category) { NewsCategory.new }

    specify { expect(subject.title).to eq(category.title) }
    specify { expect(subject.path).to eq(category.path) }
  end
end
