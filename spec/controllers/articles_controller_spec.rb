require_relative './shared_examples/get_article'

RSpec.describe ArticlesController, type: :controller do
  describe 'GET show' do
    context 'when an article does exist' do
      before do
        expect(Core::ArticleReader).to receive(:new) do
          double(Core::ArticleReader, call: article)
        end
      end

      it_should_behave_like 'a successful get article request'
    end

    context 'when an article does not exist' do
      before { allow_any_instance_of(Core::ArticleReader).to receive(:call).and_yield(Core::Article.new('some-article')) }

      it_should_behave_like 'an unsuccessful get article request'
    end

    context 'article is a redirect' do
      before do
        allow_any_instance_of(Core::ArticleReader).to receive(:call).and_yield(OpenStruct.new(redirect?: true, location: 'https://example.com', status: 301))
      end

      it 'redirect with 301 status' do
        get :show, id: 'anything', locale: I18n.locale, page_type: 'articles'
        expect(response.status).to eql(301)
      end

      it 'redirects to given location' do
        get :show, id: 'anything', locale: I18n.locale, page_type: 'articles'
        expect(response.location).to eql('https://example.com')
      end
    end
  end
end
