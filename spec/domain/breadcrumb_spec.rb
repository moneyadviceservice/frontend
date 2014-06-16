RSpec.describe Breadcrumb do
  let(:locale)   { :en }
  let(:id)       { 'category-id' }
  let(:title)    { 'category-title' }
  let(:category) { double(id: id, title: title) }

  subject { described_class.new(category) }

  before do
    allow(I18n).to receive(:locale).and_return(locale)
  end

  specify { expect(subject.title).to eq(title) }
  specify { expect(subject.path).to eq(category_path(category.id, locale: locale)) }

  context 'when the category is nil' do
    let(:category) { nil }

    specify { expect(subject.title).to eq(I18n.t('layouts.home')) }
    specify { expect(subject.path).to eq(root_path(locale: locale)) }
  end
end
