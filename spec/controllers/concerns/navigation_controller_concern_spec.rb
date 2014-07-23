RSpec.describe Navigation, :type => :controller do
  let(:category_id_1) { 'category-1' }
  let(:category_id_2) { 'category-2' }
  let(:categories) { [category_id_1, category_id_2] }

  controller do
    include Navigation

    public :active_categories
    public :active_category

    def index
      params.fetch('categories', []).each do |category|
        active_category category
      end
      head :ok
    end
  end

  context 'not setting a single active category' do
    before do
      get :index
    end

    specify { expect(controller.active_categories).to be_empty }
  end

  context 'setting a single active category' do
    let(:categories) { [category_id_1] }

    before do
      get :index, categories: categories
    end

    specify { expect(controller.active_categories).to eq(categories) }
  end

  context 'setting multiple active categories' do
    before do
      get :index, categories: categories
    end

    specify { expect(controller.active_categories).to eq(categories) }
  end

  context 'after a request which has set an active category' do
    before do
      get :index, categories: categories
      get :index
    end

    specify { expect(controller.active_categories).to be_empty }
  end

  describe '#assign_active_categories' do
    let(:klass) do
      Class.new(ApplicationController) do
        include Navigation

        public :assign_active_categories, :active_categories, :clear_active_categories
      end
    end
    let(:parent_id_1) { 'parent-id-1' }
    let(:category) do
      instance_double(Core::Category, id: category_id_1, parent_id: parent_id_1, child?: child)
    end
    let(:controller) { klass.new }

    subject { controller.active_categories }

    before do
      controller.clear_active_categories
      controller.assign_active_categories(category, category)
    end

    context 'when category is a child category' do
      let(:child) { true }

      it { is_expected.to eq([category_id_1, parent_id_1, category_id_1, parent_id_1]) }
    end

    context 'when category is not a child category' do
      let(:child) { false }

      it { is_expected.to eq([category_id_1, category_id_1]) }
    end
  end
end
