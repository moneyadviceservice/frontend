require 'spec_helper'
require 'core/interactors/article_reader'

describe ArticlesController, :type => :controller do
  describe 'GET show' do
    let(:article) { double(Core::Article, id: 'test') }
    let(:article_reader) { double(Core::ArticleReader, call: article) }

    context 'when an article does exist' do
      before do
        allow(Core::ArticleReader).to receive(:new) { article_reader }
      end

      it 'is successful' do
        get :show, id: 'foo', locale: I18n.locale

        expect(response).to be_ok
      end

      it 'instantiates an article reader' do
        expect(Core::ArticleReader).to receive(:new).with(article.id) { article_reader }

        get :show, locale: I18n.locale, id: article.id
      end

      it 'assigns the result of article reader to @article' do
        allow_any_instance_of(Core::ArticleReader).to receive(:call) { article }

        get :show, locale: I18n.locale, id: article.id

        expect(assigns(:article)).to eq(article)
      end
    end

    context 'when an article does not exist' do
      it 'raises an ActionController RoutingError' do
        allow_any_instance_of(Core::ArticleReader).to receive(:call).and_yield

        expect { get :show, id: 'foo', locale: I18n.locale }.to raise_error(ActionController::RoutingError)
      end
    end
  end
end
