require_relative 'shared_examples/optional_failure_block'

module Core
  RSpec.describe ClumpsReader do
    subject(:clumps_reader) { described_class.new }

    describe '#call' do
      before do
        allow(Registry::Repository).to receive(:[]).with(:clump) do
          double(all: data)
        end
      end

      context 'when the repository returns no data' do
        let(:data) { nil }

        it_has_behavior 'optional failure block'
      end

      context 'when the repository returns data' do
        let(:first_clump_json) { double }
        let(:second_clump_json) { double }
        let(:first_clump) { double }
        let(:second_clump) { double }
        let(:data) { [first_clump_json, second_clump_json] }

        before do
          allow(clumps_reader).to receive(:build_clump).with(first_clump_json) { first_clump }
          allow(clumps_reader).to receive(:build_clump).with(second_clump_json) { second_clump }
        end

        it 'returns a collection of the clumps' do
          expect(clumps_reader.call).to eq([first_clump, second_clump])
        end
      end
    end

    context 'private methods' do
      describe '#build_clump' do
        let(:clump_id) { double }
        let(:category_attributes) { double }
        let(:clump_link_attributes) { double }
        let(:clump_attributes) do
          {
            'id' => clump_id,
            'categories' => [category_attributes],
            'links' => [clump_link_attributes]
          }
        end

        let(:category) { double }
        let(:clump_link) { double }

        before do
          allow(clumps_reader).to receive(:build_category).with(category_attributes) { category }
          allow(clumps_reader).to receive(:build_clump_link).with(clump_link_attributes) { clump_link }
        end

        subject(:clump) { clumps_reader.send(:build_clump, clump_attributes) }

        it 'returns a clump with the right id' do
          expect(subject).to be_a(Clump)
          expect(subject.id).to eq(clump_id)
        end

        context "the clump's categories" do
          subject { clump.categories }
          it { expect(subject).to include(category) }
        end

        context "the clump's links" do
          subject { clump.links }
          it { expect(subject).to include(clump_link) }
        end
      end

      describe '#build_category' do
        let(:category_id) { double }
        let(:subcategory_id) { double }

        let(:subcategory_attributes) do
          {
            'id' => subcategory_id,
            'contents' => []
          }
        end

        let(:category_attributes) do
          {
            'id' => category_id,
            'contents' => [subcategory_attributes]
          }
        end

        subject { clumps_reader.send(:build_category, category_attributes) }

        it 'returns a category with the right id' do
          expect(subject).to be_a(Category)
          expect(subject.id).to eq(category_id)
        end

        context 'the subcategory' do
          let(:subcategory) { subject.contents.first }

          it 'is a category with the right id' do
            expect(subcategory).to be_a(Category)
            expect(subcategory.id).to eq(subcategory_id)
          end
        end
      end
    end
  end
end
