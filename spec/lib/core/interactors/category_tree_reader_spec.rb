require_relative 'shared_examples/optional_failure_block'

require 'core/entities/category'
require 'core/interactors/category_tree_reader'

module Core
  RSpec.describe CategoryTreeReader, '#call' do
    subject(:category_tree_reader) { described_class.new }

    before do
      allow(Registries::Repository).to receive(:[]).with(:category) do
        double(all: data)
      end
    end

    context 'when the repository returns no data' do
      let(:data) { nil }

      it_has_behavior 'optional failure block'
    end

    context 'when the repository returns data' do
      subject(:category_tree) { category_tree_reader.call }

      let(:data) do
        [{
           'id'          => 'life-events',
           'type'        => 'category',
           'title'       => 'Life events',
           'description' => 'When big things happen - having a baby, losing your job, getting divorced or retiring\n - it helps to be in control of your money\n',
           'contents'    => [{
                               'id'          => 'setting-up-home',
                               'type'        => 'category',
                               'title'       => 'Setting up home',
                               'description' => 'Deciding whether to rent or buy, working out what you can afford and managing\n money when sharing with others\n',
                               'contents'    => []
                             }]
         }]
      end

      it { is_expected.to be_a(Tree::TreeNode) }

      it 'has a root of home' do
        expect(category_tree.name).to eq('home')
      end

      describe 'first child category' do
        subject(:child_category_node) { category_tree.children.first }

        it { is_expected.to be_a(Tree::TreeNode) }

        it 'contains the first category' do
          expect(child_category_node.name).to eq('life-events')
          expect(child_category_node.content).to be_a(Core::Category)
        end

        describe 'first grandchild category' do
          subject(:grandchild_category_node) { child_category_node.children.first }

          it { is_expected.to be_a(Tree::TreeNode) }

          it 'contains the first category' do
            expect(grandchild_category_node.name).to eq('setting-up-home')
            expect(grandchild_category_node.content).to be_a(Core::Category)
          end
        end
      end
    end
  end
end
