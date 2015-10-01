RSpec.describe CategoriesController, type: :controller do
  before do
    allow(Core::CategoryTreeReader).to receive(:new) do
      instance_double(Core::CategoryTreeReader, call: double)
    end
  end

  describe 'GET show' do
    let(:category) { Core::Category.new('test') }
    let(:breadcrumbs) { double }

    context 'when the category exists' do
      before do
        allow(Core::CategoryReader).to receive(:new) do
          instance_double(Core::CategoryReader, call: category)
        end

        allow(BreadcrumbTrail).to receive(:build) { breadcrumbs }
      end

      it 'is successful' do
        get :show, id: category.id, locale: I18n.locale

        expect(response).to be_ok
      end

      it 'assigns @category to the result of category reader' do
        get :show, id: category.id, locale: I18n.locale

        expect(assigns(:category)).to eq(category)
      end

      it 'assigns @breadcrumbs to the result of breadcrumb reader' do
        get :show, id: category.id, locale: I18n.locale

        expect(assigns(:breadcrumbs)).to eq(breadcrumbs)
      end
    end

    context 'when the category does not exist' do
      before { allow_any_instance_of(Core::CategoryReader).to receive(:call).and_yield(category) }

      it 'raises an ActionController RoutingError' do
        expect { get :show, id: category.id, locale: I18n.locale }
          .to raise_error(ActionController::RoutingError)
      end
    end

    context 'when category is redirected' do
      let(:redirect) do
        OpenStruct.new(redirect?: true, location: 'https://example.com', status: 301)
      end

      before do
        allow_any_instance_of(Core::CategoryReader).to receive(:call)
          .and_yield(redirect)
      end

      it 'is redirected to specified location' do
        get :show, id: 'redirected', locale: 'en'
        expect(response.status).to eql(301)
        expect(response).to redirect_to('https://example.com')
      end
    end
  end
end
