require_relative 'shared_examples/optional_failure_block'
require 'core/interactors/breadcrumbs_reader'

RSpec.describe Core::BreadcrumbsReader do
  subject(:breadcrumbs_reader) { described_class.new(id, category_tree) }

  let(:id) { 'the-one-we-want' }
  let(:category_tree) { Tree::TreeNode.new(double) }

  it { is_expected.to respond_to :call }

  describe '.call' do
    subject(:breadcrumbs) { breadcrumbs_reader.call }

    context 'when the category is not found' do
      it_has_behavior 'optional failure block' do
        subject { breadcrumbs_reader }
      end
    end

    context 'when the category is found' do
      context 'within the first branches of the tree' do
        let(:category_tree) do
          Tree::TreeNode.new(double, 'root').tap do |tree|
            tree << Tree::TreeNode.new(double)
            tree << Tree::TreeNode.new(double)
            tree << Tree::TreeNode.new(id)
            tree << Tree::TreeNode.new(double)
          end
        end

        it 'returns the parent nodes' do
          expect(breadcrumbs).to eq(%w(root))
        end
      end

      context 'within the second branches of the tree' do
        let(:category_tree) do
          Tree::TreeNode.new(double, 'root').tap do |tree|
            tree << Tree::TreeNode.new(double)
            tree << Tree::TreeNode.new(double)
            tree << Tree::TreeNode.new(double, 'branch').tap do |sub_tree|
              sub_tree << Tree::TreeNode.new(double)
              sub_tree << Tree::TreeNode.new(id)
              sub_tree << Tree::TreeNode.new(double)
            end
            tree << Tree::TreeNode.new(double)
          end
        end

        it 'returns the parent nodes' do
          expect(breadcrumbs).to eq(%w(root branch))
        end
      end

      context 'within the third branches of the tree' do
        let(:category_tree) do
          Tree::TreeNode.new(double, 'root').tap do |tree|
            tree << Tree::TreeNode.new(double)
            tree << Tree::TreeNode.new(double)
            tree << Tree::TreeNode.new(double, 'branch').tap do |sub_tree|
              sub_tree << Tree::TreeNode.new(double)
              sub_tree << Tree::TreeNode.new(double, 'twig').tap do |sub_sub_tree|
                sub_sub_tree << Tree::TreeNode.new(double)
                sub_sub_tree << Tree::TreeNode.new(id)
                sub_sub_tree << Tree::TreeNode.new(double)
              end
            end
            tree << Tree::TreeNode.new(double)
          end
        end

        it 'returns the parent nodes' do
          expect(breadcrumbs).to eq(%w(root branch twig))
        end
      end
    end
  end
end
