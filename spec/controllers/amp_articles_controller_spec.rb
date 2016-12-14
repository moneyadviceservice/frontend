RSpec.describe AmpArticlesController, type: :controller do
  let(:supports_amp) { false }
  let(:article) { build(:article, supports_amp: supports_amp) }
  let(:request) { get :show, article_id: article.id, locale: I18n.locale }
  describe 'GET amp' do
    context 'article exists' do
      before(:each) do
        expect(Core::ArticleReader).to receive(:new).with(article.id) do
          double(Core::ArticleReader, call: article)
        end
        request
      end

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
          expect(assigns(:article)).to eq(article)
        end

      end
     end

    context 'article does not exist' do
      before(:each) do
        allow_any_instance_of(Core::ArticleReader).to receive(:call).and_yield(Core::Article.new('some-article'))
      end

      it 'returns a 404' do
        expect { request }.to raise_error(ActionController::RoutingError)
      end
    end

    context 'article is a redirect' do
      before do
        allow_any_instance_of(Core::ArticleReader).to receive(:call).and_yield(OpenStruct.new(redirect?: true, location: 'https://example.com', status: 301))
        request
      end

      it 'redirect with 301 status' do
        expect(response.status).to eql(301)
      end

      it 'redirects to given location' do
        expect(response.location).to eql('https://example.com')
      end
    end
  end
end
