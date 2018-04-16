RSpec.describe AmpArticlesController, type: :controller do
  describe 'GET /:locale/articles/:article_id/amp' do
    context 'article exists' do
      before(:each) do
        expect_any_instance_of(
          Mas::Cms::Article
        ).to receive(:supports_amp).and_return(supports_amp)
        get :show, article_id: article_id, locale: I18n.locale
      end

      let(:article_id) { 'how-much-rent-can-you-afford' }

      context 'article does not supports amp' do
        let(:supports_amp) { false }

        it 'returns a 302' do
          expect(response.status).to eql(302)
        end
      end

      context 'article supports amp' do
        let(:supports_amp) { true }

        it 'returns a 200' do
          expect(response.status).to eql(200)
        end

        it 'assigns the result of article reader to @article' do
          expect(assigns(:article).id).to eq(article_id)
        end
      end
    end

    context 'article does not exist' do
      let(:article_id) { 'fake-article' }

      it 'returns a 404' do
        expect do
          get :show, article_id: article_id, locale: I18n.locale
        end.to raise_error(ActionController::RoutingError)
      end
    end

    context 'article is a redirect' do
      before(:each) do
        get :show, article_id: article_id, locale: I18n.locale
      end

      let(:article_id) do
        'building-a-credit-history-as-a-young-consumer'
      end

      it 'redirect with 301 status' do
        expect(response.status).to eql(301)
      end

      it 'redirects to given location' do
        expect(response.location)
          .to match('en/articles/how-to-improve-your-credit-rating')
      end
    end
  end
end
