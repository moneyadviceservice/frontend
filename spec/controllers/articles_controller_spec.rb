require 'spec_helper'
require 'core/interactors/article_reader'

RSpec.describe ArticlesController, :type => :controller do
  before do
    allow(Core::CategoryTreeReader).to receive(:new) do
      instance_double(Core::CategoryTreeReader, call: category_tree)
    end
  end

  let(:category_tree) { double }

  describe 'GET show' do
    let(:article) { Core::Article.new('test', categories: categories) }
    let(:categories) { [] }
    let(:breadcrumbs) { [] }

    context 'when an article does exist' do
      before do
        allow(Core::ArticleReader).to receive(:new) do
          double(Core::ArticleReader, call: article)
        end

        allow(BreadcrumbTrail).to receive(:build) { breadcrumbs }
      end

      it 'is successful' do
        get :show, id: article.id, locale: I18n.locale

        expect(response).to be_ok
      end

      it 'assigns the result of article reader to @article' do
        get :show, id: article.id, locale: I18n.locale

        expect(assigns(:article)).to eq(article)
      end

      it 'reads the breadcrumbs for the article' do
        expect(BreadcrumbTrail).to receive(:build).with(article, category_tree)

        get :show, id: article.id, locale: I18n.locale
      end

      it 'assigns the breadcrumbs to @breadcrumbs' do
        get :show, id: article.id, locale: I18n.locale

        expect(assigns(:breadcrumbs)).to eq(breadcrumbs)
      end
    end

    context 'when an article does not exist' do
      before { allow_any_instance_of(Core::ArticleReader).to receive(:call).and_yield }

      it 'raises an ActionController RoutingError' do
        expect { get :show, id: article.id, locale: I18n.locale }.
          to raise_error(ActionController::RoutingError)
      end
    end
  end
end
