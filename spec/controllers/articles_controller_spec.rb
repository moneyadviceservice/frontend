require 'spec_helper'
require 'core/interactors/article_reader'

describe ArticlesController do
  describe 'GET show' do
    let(:article) { double(Core::Article, id: 'test') }
    let(:article_reader) { double(Core::ArticleReader, call: article) }

    it 'is successful' do
      allow(Core::ArticleReader).to receive(:new) { article_reader }

      get :show, id: 'foo', locale: I18n.locale

      expect(response).to be_ok
    end

    it 'instantiates an article reader' do
      expect(Core::ArticleReader).to receive(:new).with(article.id) { article_reader }

      get :show, locale: I18n.locale, id: article.id
    end

    it 'assigns @article to the result of article reader' do
      allow_any_instance_of(Core::ArticleReader).to receive(:call) { article }

      get :show, locale: I18n.locale, id: article.id

      expect(assigns(:article)).to eq(article)
    end
  end
end
