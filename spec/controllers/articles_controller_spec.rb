RSpec.describe ArticlesController, type: :controller do
  def attributes
    {
      id: article.id,
      locale: I18n.locale,
      page_type: 'articles'
    }
  end

  describe 'GET show' do
    context 'when article exists' do
      before { get :show, attributes }

      let(:article) { double(id: 'how-much-rent-can-you-afford') }

      it { is_expected.to respond_with 200 }
    end

    context 'when article does not exist' do
      let(:article) { double(id: 'fake-article') }

      it 'returns resource not found error' do
        expect{
          get :show, attributes
        }.to raise_error(ActionController::RoutingError)
      end
    end
  end

  describe '#redirect' do
    context 'article is a redirect' do
      before { get :show, attributes }

      let(:article) do
        double(id: 'building-a-credit-history-as-a-young-consumer')
      end

      it { is_expected.to respond_with 301 }

      it 'redirects to given location' do
        expect(response.location).to match(
          'http://localhost:5000/en/articles/how-to-improve-your-credit-rating'
        )
      end
    end
  end

  describe '#set_article_canonical_url' do
    subject(:article_canonical_url) { assigns(:article_amp_url) }

    before do
      allow(Mas::Cms::Article).to receive(:find).and_return(article)

      get :show, attributes
    end

    context 'article supports AMP' do
      let(:article) do
        double(id: 'free-printed-guides', categories: [], supports_amp: true)
      end

      it 'sets article_canonical_url to the AMP url' do
        expect(article_canonical_url).to match(
          'http://test.host/en/articles/free-printed-guides/amp'
        )
      end
    end

    context 'article does not support AMP' do
      let(:article) do
        double(id: 'free-printed-guides', categories: [], supports_amp: false)
      end

      it 'sets article_canonical_url to the amp url' do
        expect(article_canonical_url).to eq(nil)
      end
    end
  end

  describe '#assigns to @article' do
    context 'article does not exist' do
      let(:article) do
        double(id: 'fake-article', categories: [], supports_amp: false)
      end

      it 'raises a routing error' do
        expect {
          get :show, attributes
        }.to raise_error(ActionController::RoutingError)
      end
    end

    context 'article exists' do
      before do
        get :show, attributes
      end

      let(:article) do
        double(id: 'free-printed-guides')
      end

      it 'returns article from MAS CMS API' do
        expect(assigns(:article)).to be_a(Mas::Cms::Article)
      end
    end
  end

  describe '#assigns to @breadcrumb' do
    context 'article exists and has breadcrumbs' do
      let(:article) { double(id: 'free-printed-guides') }
      let(:breadcrumbs) { [] }

      it 'assigns breadcrumbs' do
        allow(BreadcrumbTrail).to receive(:build).and_return(breadcrumbs)
        get :show, attributes

        expect(assigns(:breadcrumbs)).to match(breadcrumbs)
      end
    end
  end
end
