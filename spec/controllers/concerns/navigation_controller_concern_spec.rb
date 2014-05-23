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
end
