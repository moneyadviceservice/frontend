require 'spec_helper'
require 'core/entities/category'

module Core
  describe Category do
    subject { described_class.new(double, attributes) }

    let(:attributes) { { title:       double,
                         description: double,
                         contents:    double } }

    it { should respond_to :type }
    it { should respond_to :type= }

    it { should respond_to :title }
    it { should respond_to :title= }

    it { should respond_to :description }
    it { should respond_to :description= }

    it { should respond_to :contents }
    it { should respond_to :contents= }

    it { should validate_presence_of(:title) }

    describe 'category hierarchy' do
      let(:category_with_nil_contents) { build :category, contents: nil }
      let(:child_category) { build :category, contents: [build(:article), build(:action_plan)] }
      let(:parent_category) { build :category, contents: [child_category] }
      let(:grandparent_category) { build :category, contents: [parent_category, child_category] }

      specify { expect(category_with_nil_contents).to be_child }

      specify { expect(child_category).to be_child }
      specify { expect(child_category).to_not be_parent }
      specify { expect(child_category).to_not be_grandparent }

      specify { expect(parent_category).to be_parent }
      specify { expect(parent_category).to_not be_child }
      specify { expect(parent_category).to_not be_grandparent }

      specify { expect(grandparent_category).to be_grandparent }
      specify { expect(grandparent_category).to_not be_child }
      specify { expect(grandparent_category).to be_parent }
    end
  end
end
