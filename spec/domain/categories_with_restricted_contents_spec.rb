RSpec.describe CategoriesWithRestrictedContents, '.build' do
  let(:category_1)     { Core::Category.new(double, contents: [item_1, item_2, other_item_1]) }
  let(:category_2)     { Core::Category.new(double, contents: [item_3, other_item_2]) }
  let(:item_1)         { double }
  let(:item_2)         { double }
  let(:item_3)         { double }
  let(:other_item_1)   { double }
  let(:other_item_2)   { double }
  let(:categories)     { [category_1, category_2] }
  let(:relevant_items) { [item_1, item_2, item_3] }

  subject { described_class.build(categories, relevant_items) }

  specify { expect(subject).to eq(categories) }
  specify { expect(subject.first.contents).to contain_exactly(item_1, item_2) }
  specify { expect(subject.last.contents).to contain_exactly(item_3) }
end
