RSpec.describe NewsController, type: :controller do
  describe 'GET show' do
    let(:news_article) { instance_double(Core::NewsArticle, id: 'test', categories: []) }
    let(:news_reader) { instance_double(Core::NewsArticleReader, call: news_article) }
    let(:news_article_reader) { instance_double(Core::NewsArticleReader, call: news_article) }
    let(:category_tree) { double }

    before do
      allow(Core::NewsArticleReader).to receive(:new) { news_reader }
      allow(Core::CategoryTreeReader).to receive(:new) do
        instance_double(Core::CategoryTreeReader, call: category_tree)
      end
      allow(Core::NewsReader).to receive(:new) { -> { [] } }
    end

    it 'is succesful' do
      get :show, locale: I18n.locale, id: news_article.id

      expect(response).to be_ok
    end

    it 'instantites an NewsArticleReader' do
      expect(Core::NewsArticleReader).to receive(:new).with(news_article.id) { news_article_reader }

      get :show, locale: I18n.locale, id: news_article.id
    end

    it 'assigns @news_article to the result of NewsArticleReader' do
      get :show, locale: I18n.locale, id: news_article.id

      expect(assigns(:news_article)).to eq(news_article)
    end
  end

  describe 'GET #show' do
    context 'when a news article does not exist' do
      let(:article) do
        Core::NewsArticle.new('do-not-exist')
      end

      before do
        allow_any_instance_of(Core::NewsArticleReader).to receive(:call).and_yield(article)
      end

      it 'raises an ActionController RoutingError' do
        expect { get :show, id: 'foo', locale: I18n.locale }.to raise_error(ActionController::RoutingError)
      end
    end

    context 'when news article is redirected' do
      let(:redirect) do
        OpenStruct.new(status: 301, location: 'https://example.com', redirect?: true)
      end

      before do
        allow_any_instance_of(Core::NewsArticleReader).to receive(:call).and_yield(redirect)
      end

      it 'redirects to specified location' do
        get :show, id: 'redirect', locale: I18n.locale
        expect(response).to redirect_to('https://example.com')
      end

      it 'redirects with specified status code' do
        get :show, id: 'redirect', locale: I18n.locale
        expect(response.status).to eql(301)
      end
    end
  end

  describe 'GET index' do
    let(:news) { [] }
    let(:news_reader) { instance_double(Core::NewsReader, call: news) }

    before { allow_any_instance_of(Core::NewsReader).to receive(:call) { news } }

    it 'is succesful' do
      get :index, locale: I18n.locale

      expect(response).to be_ok
    end

    it 'instantites a NewsReader' do
      expect(Core::NewsReader).to receive(:new) { news_reader } { news_reader }

      get :index, locale: I18n.locale
    end

    it 'assigns @news to the result of NewsReader' do
      get :index, locale: I18n.locale

      expect(assigns(:news)).to eq(news)
    end

    context 'when news index does not exist' do
      it 'raises an ActionController RoutingError' do
        allow_any_instance_of(Core::NewsReader).to receive(:call).and_yield

        expect { get :index, locale: I18n.locale }.to raise_error(ActionController::RoutingError)
      end
    end
  end
end
