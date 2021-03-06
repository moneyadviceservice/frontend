module Core
  RSpec.describe Category, type: :model do
    subject { described_class.new(double, attributes) }

    let(:attributes) do
      {
        title:       double,
        parent_id:   double,
        description: double,
        contents:    double,
        images:      double,
        links:       double,
        category_promos: double,
        legacy_contents: double
      }
    end

    it 'have category attributes' do
      is_expected.to have_attributes(
        :type,
        :parent_id,
        :title,
        :description,
        :contents,
        :images,
        :links,
        :category_promos,
        :legacy_contents
      )
    end
    it { is_expected.to validate_presence_of(:title) }

    specify { expect(subject).to_not be_home }
    specify { expect(subject).to_not be_news }

    describe 'category hierarchy' do
      let(:category_with_nil_contents) { build :category, contents: nil }
      let(:child_category) do
        build :category, contents: [build(:article), build(:article)]
      end
      let(:parent_category) { build :category, contents: [child_category] }
      let(:category_with_legacy_contents) do
        build :category, legacy_contents: [build(:article)], legacy: true
      end

      specify { expect(category_with_nil_contents).to be_child }

      specify { expect(child_category).to be_child }
      specify { expect(child_category).to_not be_parent }

      specify { expect(parent_category).to be_parent }
      specify { expect(parent_category).to_not be_child }

      specify { expect(category_with_legacy_contents.legacy?).to be true }
    end

    describe '#categories' do
      let(:category) { double(type: 'category') }
      let(:another_category) { double(type: 'category') }
      let(:article) { double(type: 'article') }

      before { attributes[:contents] = [category, article, another_category] }

      it 'only returns the catgories' do
        expect(subject.categories).to eq [category, another_category]
      end
    end
  end
end
