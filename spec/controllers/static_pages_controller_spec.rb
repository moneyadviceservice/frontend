RSpec.describe StaticPagesController, :type => :controller do
  describe 'GET show' do
    let(:categories) { [] }
    let(:parents) { [] }
    let(:static_page) { Core::StaticPage.new('test', categories: categories) }
    let(:static_page_reader) { double(Core::StaticPageReader, call: static_page) }

    context 'when an static_page does exist' do
      context 'and id is that of the contact page' do
        let(:id) { StaticPagesController::CONTACT_PAGE_ID_EN }

        it 'is successful' do
          get :show, locale: I18n.locale, id: id

          expect(response).to be_ok
        end

        it 'does not instantiate an static_page reader' do
          expect(Core::StaticPageReader).to_not receive(:new)

          get :show, locale: I18n.locale, id: id
        end

        it 'renders the custom contact_us template' do
          get :show, locale: I18n.locale, id: id
          expect(response).to render_template('static_pages/show_contact_us')
        end
      end

      context 'and id is not that of the contact page' do
        before do
          allow(Core::StaticPageReader).to receive(:new) { static_page_reader }
          allow(Core::CategoryTreeReader).to receive(:new) { -> { double } }
        end

        it 'is successful' do
          get :show, id: 'foo', locale: I18n.locale

          expect(response).to be_ok
        end

        it 'instantiates an static_page reader' do
          expect(Core::StaticPageReader).to receive(:new).with(static_page.id) { static_page_reader }

          get :show, locale: I18n.locale, id: static_page.id
        end

        it 'assigns the result of static_page reader to @static_page' do
          allow_any_instance_of(Core::StaticPageReader).to receive(:call) { static_page }

          get :show, locale: I18n.locale, id: static_page.id

          expect(assigns(:static_page)).to eq(static_page)
        end
      end
    end

    context 'when an static_page does not exist' do
      it 'raises an ActionController RoutingError' do
        allow_any_instance_of(Core::StaticPageReader).to receive(:call).and_yield

        expect { get :show, id: 'foo', locale: I18n.locale }.to raise_error(ActionController::RoutingError)
      end
    end
  end
end
