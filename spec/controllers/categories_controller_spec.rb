require 'spec_helper'
require 'core/interactors/category_reader'

RSpec.describe CategoriesController, :type => :controller do
  describe 'GET show' do
    let(:category) { instance_double(Core::Category, id: 'test') }
    let(:category_reader) { instance_double(Core::CategoryReader, call: category) }

    it 'is successful' do
      allow(Core::CategoryReader).to receive(:new) { category_reader }

      get :show, id: 'foo', locale: I18n.locale

      expect(response).to be_ok
    end

    it 'instantiates a category reader' do
      expect(Core::CategoryReader).to receive(:new).with(category.id) { category_reader }

      get :show, locale: I18n.locale, id: category.id
    end

    it 'assigns @category to the result of category reader' do
      allow_any_instance_of(Core::CategoryReader).to receive(:call) { category }

      get :show, locale: I18n.locale, id: category.id

      expect(assigns(:category)).to eq(category)
    end

    context 'when a category does not exist' do
      it 'raises an ActionController RoutingError' do
        allow_any_instance_of(Core::CategoryReader).to receive(:call).and_yield

        expect { get :show, id: 'foo', locale: I18n.locale }.to raise_error(ActionController::RoutingError)
      end
    end
  end
end
