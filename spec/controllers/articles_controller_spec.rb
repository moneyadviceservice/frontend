require 'spec_helper'
require 'core/interactors/article_reader'

describe ArticlesController do
  describe 'GET show' do

    let(:article) { double(Core::Article, id: 'test') }

    it 'is successful' do
      get :show, id: 'foo', locale: I18n.locale

      expect(response).to be_ok
    end

    it 'instantiates an article reader' do
      expect(Core::ArticleReader).
          to receive(:new).with(article.id) { double(Core::ArticleReader, call: article) }

      get :show, locale: I18n.locale, id: article.id
    end

    it 'assigns @article to the result of article reader' do
      allow_any_instance_of(Core::ArticleReader).to receive(:call) { article }

      get :show, locale: I18n.locale, id: article.id

      expect(assigns(:article)).to eq(article)
    end
  end
end
