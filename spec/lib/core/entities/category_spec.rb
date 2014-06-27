require 'core/entities/category'

module Core
  RSpec.describe Category do
    subject { described_class.new(double, attributes) }

    let(:attributes) { { title:       double,
                         parent_id:   double,
                         description: double,
                         contents:    double } }

    it { is_expected.to respond_to :type }
    it { is_expected.to respond_to :type= }

    it { is_expected.to respond_to :parent_id }
    it { is_expected.to respond_to :parent_id= }

    it { is_expected.to respond_to :title }
    it { is_expected.to respond_to :title= }

    it { is_expected.to respond_to :description }
    it { is_expected.to respond_to :description= }

    it { is_expected.to respond_to :contents }
    it { is_expected.to respond_to :contents= }

    it { is_expected.to validate_presence_of(:title) }

    specify { expect(subject).to_not be_home }

    describe 'category hierarchy' do
      let(:category_with_nil_contents) { build :category, contents: nil }
      let(:child_category) { build :category, contents: [build(:article), build(:action_plan)] }
      let(:parent_category) { build :category, contents: [child_category] }

      specify { expect(category_with_nil_contents).to be_child }

      specify { expect(child_category).to be_child }
      specify { expect(child_category).to_not be_parent }

      specify { expect(parent_category).to be_parent }
      specify { expect(parent_category).to_not be_child }
    end
  end
end
