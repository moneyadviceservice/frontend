RSpec.describe StaticPagesController, :type => :controller do
  describe 'GET show' do
    let(:categories) { [] }
    let(:parents) { [] }
    let(:static_page_id) { 'test' }
    let(:static_page) { Core::StaticPage.new(static_page_id, categories: categories) }
    let(:static_page_reader) { double(Core::StaticPageReader, call: static_page) }

    context 'when an static_page does exist' do
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

      context 'if there is a custom template' do
        let(:static_page_id) { 'contact-us' }
        subject { get :show, locale: I18n.locale, id: static_page.id }

        it 'renders the custom template' do
          expect(subject).to render_template("static_pages/#{static_page_id.underscore}")
        end
      end

      context 'if there is no custom template' do
        subject { get :show, locale: I18n.locale, id: static_page.id }

        it 'renders the default template' do
          expect(subject).to render_template("static_pages/show")
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
