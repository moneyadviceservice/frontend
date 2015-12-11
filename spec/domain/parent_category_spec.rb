RSpec.describe ParentCategory do
  describe '.find' do
    let(:entity) { double(id: 'root') }
    let(:category_tree) do
      Tree::TreeNode.new(entity.id, entity)
    end

    context 'when article does not have category' do
      let(:page) { double(categories: []) }

      it 'returns nil' do
        expect(ParentCategory.find(page, category_tree)).to be(nil)
      end
    end

    context 'when article has one parent category' do
      let(:page) { double(categories: [category]) }
      let(:category) do
        double(title: 'Before you borrow', parent_id: 'debt-and-borrowing', home?: false)
      end

      let(:parent_category) do
        double('ParentCategory', title: 'Debt and borrowing', parent_id: '', home?: false)
      end

      let(:home_category) do
        double('HomeCategory', home?: true)
      end

      let(:page_categories) do
        [home_category, category, parent_category]
      end

      before do
        expect(RootToNodePath).to receive(:build).and_return(page_categories)
      end

      it 'returns parent category' do
        expect(ParentCategory.find(page, category_tree)).to eq(parent_category)
      end
    end
  end
end
