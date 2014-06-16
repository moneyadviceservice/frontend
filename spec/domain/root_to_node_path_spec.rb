RSpec.describe RootToNodePath, '.build' do
  let(:category)      { double(id: 'the-one-we-want') }
  let(:root)          { double(id: 'root') }
  let(:branch)        { double(id: 'branch') }
  let(:twig)          { double(id: 'twig') }
  let(:category_node) { make_node(category) }
  let(:root_node)     { make_node(root) }
  let(:branch_node)   { make_node(branch) }
  let(:twig_node)     { make_node(twig) }
  let(:category_tree) { root_node }

  def make_node(entity)
    Tree::TreeNode.new(entity.id, entity)
  end

  def other_node
    make_node(double(id: double))
  end

  subject { described_class.build(category, category_tree) }

  context 'when the category is not found' do
    let(:category) { double(id: 'not-the-one-we-want') }

    it { is_expected.to be_empty }
  end

  context 'when the category is found' do
    context 'within the first branches of the tree' do
      let(:category_tree) do
        root_node.tap do |tree|
          tree << other_node
          tree << other_node
          tree << category_node
          tree << other_node
        end
      end

      it { is_expected.to eq([root, category]) }
    end

    context 'within the second branches of the tree' do
      let(:category_tree) do
        root_node.tap do |tree|
          tree << other_node
          tree << other_node
          tree << branch_node.tap do |sub_tree|
            sub_tree << other_node
            sub_tree << category_node
            sub_tree << other_node
          end
          tree << other_node
        end
      end

      it { is_expected.to eq([root, branch, category]) }
    end

    context 'within the third branches of the tree' do
      let(:category_tree) do
        root_node.tap do |tree|
          tree << other_node
          tree << other_node
          tree << branch_node.tap do |sub_tree|
            sub_tree << other_node
            sub_tree << twig_node.tap do |sub_sub_tree|
              sub_sub_tree << other_node
              sub_sub_tree << category_node
              sub_sub_tree << other_node
            end
          end
          tree << other_node
        end
      end

      it { is_expected.to eq([root, branch, twig, category]) }
    end
  end
end
