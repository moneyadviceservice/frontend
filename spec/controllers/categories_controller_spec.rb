require 'core/interactors/category_reader'
require 'core/interactors/category_parents_reader'

RSpec.describe CategoriesController, :type => :controller do
  describe 'GET show' do
    let(:category) { double(Core::Category, id: 'test', parent_id: 'parent-id') }
    let(:category_reader) { double(Core::CategoryReader, call: category) }
    let(:category_parent_reader) { double(Core::CategoryParentsReader, call: category) }

    it 'is successful' do
      allow(Core::CategoryReader).to receive(:new) { category_reader }
      allow(Core::CategoryParentsReader).to receive(:new) { category_parent_reader }

      get :show, id: 'foo', locale: I18n.locale

      expect(response).to be_ok
    end

    it 'instantiates a category reader' do
      allow(Core::CategoryParentsReader).to receive(:new) { category_parent_reader }
      expect(Core::CategoryReader).to receive(:new).with(category.id) { category_reader }

      get :show, locale: I18n.locale, id: category.id
    end

    xit 'instantiates a parent reader' do
      allow(Core::CategoryReader).to receive(:new) { category_reader }
      expect(Core::CategoryParentsReader).to receive(:new).with(category) { category_parent_reader }

      get :show, locale: I18n.locale, id: category.id
    end

    it 'assigns @category to the result of category reader' do
      allow(Core::CategoryParentsReader).to receive(:new) { category_parent_reader }
      allow_any_instance_of(Core::CategoryReader).to receive(:call) { category }

      get :show, locale: I18n.locale, id: category.id

      expect(assigns(:category)).to eq(category)
    end

    xit 'assigns @category_hierarchy to the result of category parent reader' do
      allow(Core::CategoryReader).to receive(:new) { category_reader }
      allow_any_instance_of(Core::CategoryParentsReader).to receive(:call) { [category] }

      get :show, locale: I18n.locale, id: category.id

      expect(assigns(:category_hierarchy)).to eq([category])
    end

    context 'when a category does not exist' do
      it 'raises an ActionController RoutingError' do
        allow_any_instance_of(Core::CategoryReader).to receive(:call).and_yield

        expect { get :show, id: 'foo', locale: I18n.locale }.to raise_error(ActionController::RoutingError)
      end
    end
  end
end
