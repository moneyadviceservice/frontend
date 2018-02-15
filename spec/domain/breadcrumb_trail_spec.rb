RSpec.describe BreadcrumbTrail, '.build' do
  let(:article)               { Mas::Cms::Article.new('the-article') }
  let(:category_id)           { 'the-category' }
  let(:tool_category_id)      { 'the-tool-category' }
  let(:tool_category)         { Mas::Cms::Category.new(tool_category_id, title: 'some tool category') }
  let(:parent_category_id)    { 'the-parent-category' }
  let(:parent_category)       { Mas::Cms::Category.new(parent_category_id, title: 'some parent category') }
  let(:other_category)        { Mas::Cms::Category.new('other-category', title: 'some other category') }
  let(:path_to_category)      { [parent_category, category] }
  let(:category_tree)         { double }
  let(:category) do
    Mas::Cms::Category.new(category_id, title: 'some category', parent_id: parent_category.id)
  end

  before do
    allow(tool_category).to receive(:entity) { category }
    allow(RootToNodePath).to receive(:build).with(tool_category, category_tree).and_return(path_to_category)
    allow(RootToNodePath).to receive(:build).with(category, category_tree).and_return(path_to_category)
  end

  context 'when item is an article' do
    subject { described_class.build(article, category_tree) }

    context 'and it exists in a single category' do
      before do
        expect(article).to receive(:categories).and_return([category]).at_least(:once)
      end

      specify do
        expect(subject.map(&:path)).to eq(
          [
            '/en/categories/the-parent-category',
            '/en/categories/the-category'
          ]
        )
      end
    end

    context 'and it exists in more than one category' do
      before do
        expect(article).to receive(:categories).and_return([category, other_category]).at_least(:once)
      end

      it { is_expected.to be_empty }
    end

    context 'and it does not exist within a category' do
      before do
        expect(article).to receive(:categories).and_return([])
      end

      specify do
        expect(subject.map(&:path)).to eq(['/en'])
      end
    end
  end

  context 'when item is a category' do
    before do
      allow(Mas::Cms::Category).to receive(:find)
        .with(parent_category_id, locale: I18n.locale)
        .and_return(parent_category)
    end

    subject { described_class.build_category_trail(category) }

    specify { expect(subject.map(&:path)).to eq(['/en', '/en/categories/the-parent-category']) }

    context 'and has no parent category' do
      before do
        allow(category).to receive(:parent_id).and_return(nil)
      end

      specify { expect(subject.map(&:path)).to eq(['/en']) }
    end
  end

  context 'when item is a tool category' do
    before do
      allow(Mas::Cms::Category).to receive(:find)
        .with(tool_category_id, locale: I18n.locale)
        .and_return(tool_category)
    end

    subject { described_class.build_tool_trail(tool_category) }

    specify { expect(subject.map(&:path)).to eq(['/en', '/en/categories/the-tool-category']) }
  end
end

RSpec.describe BreadcrumbTrail, '.home' do
  subject { described_class.home }

  specify { expect(subject.map(&:title)).to eq([HomeCategory.new.title]) }
end
