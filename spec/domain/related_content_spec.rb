RSpec.describe RelatedContent, '.build' do
  let(:item)  { double }
  let(:limit) { 4 }

  subject { described_class.build(item, limit) }

  context 'when we only have one category' do
    let(:item)     { double(categories: [category]) }
    let(:category) { double(contents: contents) }
    let(:contents) { [double] }

    context 'when we have fewer items than the limit' do
      specify { expect(subject).to eq(contents) }
    end

    context 'when we have more items than the limit' do
      let(:relevant_items)    { Array.new(limit) { double } }
      let(:superfluous_items) { [double] }
      let(:contents)          { relevant_items + superfluous_items }

      specify { expect(subject).to eq(relevant_items) }
    end
  end

  context 'when we have two categories' do
    let(:category_1)          { double(contents: category_1_contents) }
    let(:category_1_contents) { [] }
    let(:category_2)          { double(contents: category_2_contents) }
    let(:category_2_contents) { [] }
    let(:item)                { double(categories: [category_1, category_2]) }

    context 'when we have more than enough items in both categories' do
      let(:category_1_relevant_items)    { Array.new(limit / 2) { double } }
      let(:category_1_superfluous_items) { [double] }
      let(:category_1_contents)          { category_1_relevant_items + category_1_superfluous_items }

      let(:category_2_relevant_items)    { Array.new(limit / 2) { double } }
      let(:category_2_superfluous_items) { [double] }
      let(:category_2_contents)          { category_2_relevant_items + category_2_superfluous_items }

      let(:relevant_content) { category_1_relevant_items + category_2_relevant_items }

      specify { expect(subject).to contain_exactly(*relevant_content) }
    end

    context 'when the first category has too few items' do
      let(:category_1_contents) { [double] }

      context 'and the second category also has too few items' do
        let(:category_2_contents) { [double, double] }

        let(:relevant_content) { category_1_contents + category_2_contents }

        specify { expect(subject).to contain_exactly(*relevant_content) }
      end

      context 'and the second category has more than enough items' do
        let(:category_2_relevant_items)    { Array.new(limit - 1) { double } }
        let(:category_2_superfluous_items) { [double] }
        let(:category_2_contents)          { category_2_relevant_items + category_2_superfluous_items }

        let(:relevant_content) { category_1_contents + category_2_relevant_items }

        specify { expect(subject).to contain_exactly(*relevant_content) }
      end
    end

    context 'when the first category has more than enough items' do
      let(:category_1_relevant_items)    { Array.new(limit - 1) { double } }
      let(:category_1_superfluous_items) { [double] }
      let(:category_1_contents)          { category_1_relevant_items + category_1_superfluous_items }

      context 'and the second category has too few items' do
        let(:category_2_contents) { [double] }

        let(:relevant_content) { category_1_relevant_items + category_2_contents }

        specify { expect(subject).to contain_exactly(*relevant_content) }
      end
    end
  end
end
