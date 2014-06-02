require_relative 'shared_examples/optional_failure_block'
require 'core/interactors/breadcrumbs_reader'

RSpec.describe Core::BreadcrumbsReader do
  subject(:breadcrumbs_reader) { described_class.new(id) }

  let(:id) { 'the-one-we-want' }

  it { is_expected.to respond_to :call }

  describe '.call' do
    before do
      allow(Core::CategoryTreeReader).to receive(:new) { double(call: tree) }
    end

    context 'when the repository returns no data' do
      let(:tree) { nil }

      it_has_behavior 'optional failure block'
    end

    context 'when the category is not found' do
      let(:tree) { Tree::TreeNode.new('home') }

      subject(:breadcrumbs) { breadcrumbs_reader.call }

      it { is_expected.to eq([]) }
    end

    context 'when the category is found' do
      subject(:breadcrumbs) { breadcrumbs_reader.call }

      context 'at the first level of the three' do

        let(:tree) do
          root_node = Tree::TreeNode.new('home', Core::Category.new('home'))
          root_node << Tree::TreeNode.new(double, Core::Category.new(double))
          root_node << Tree::TreeNode.new(id, Core::Category.new(id))

          root_node
        end

        it 'returns an array of categories' do
          expect(breadcrumbs).to be_a(Array)
          expect(breadcrumbs.first).to be_a(Core::Category)
        end

        it 'returns home' do
          expect(breadcrumbs.first.id).to eq('home')
        end
      end

      context 'at a branch of the tree' do
        let(:tree) do
          root_node = Tree::TreeNode.new('home', Core::Category.new('home'))
          root_node <<
            Tree::TreeNode.new(double, Core::Category.new('the-parent')) <<
              Tree::TreeNode.new(id, Core::Category.new(id))

          root_node << Tree::TreeNode.new(double, Core::Category.new(double))

          root_node
        end

        it 'returns two categories' do
          expect(breadcrumbs.size).to eq(2)
        end

        context 'the first breadcrumb' do
          it 'is the parent category' do
            expect(breadcrumbs.first.id).to eq('the-parent')
          end
        end

        context 'the second breadcrumb' do
          it 'is the home' do
            expect(breadcrumbs.second.id).to eq('home')
          end
        end
      end

      context 'at a twig of the tree' do
        let(:tree) do
          root_node = Tree::TreeNode.new('home', Core::Category.new('home'))
          root_node <<
            Tree::TreeNode.new(double, Core::Category.new('the-grandparent')) <<
              Tree::TreeNode.new(double, Core::Category.new('the-parent')) <<
                Tree::TreeNode.new(id, Core::Category.new(id))

          root_node << Tree::TreeNode.new(double, Core::Category.new(double))

          root_node
        end

        it 'returns three breadcrumbs' do
          expect(breadcrumbs.size).to eq(3)
        end

        context 'the first breadcrumb' do
          it 'is the parent category' do
            expect(breadcrumbs.first.id).to eq('the-parent')
          end
        end

        context 'the second breadcrumb' do
          it 'is the grandparent category' do
            expect(breadcrumbs.second.id).to eq('the-grandparent')
          end
        end

        context 'the third breadcrumb' do
          it 'is the home' do
            expect(breadcrumbs.third.id).to eq('home')
          end
        end
      end
    end
  end
end
