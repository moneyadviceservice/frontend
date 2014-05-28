require 'spec_helper'
require 'core/interactors/category_parents_reader'
require 'core/interactors/article_reader'

RSpec.describe ArticlesController, :type => :controller do
  describe 'GET show' do
    let(:categories) { [] }
    let(:parents) { [] }
    let(:article) { Core::Article.new('test', categories: categories ) }
    let(:article_reader) { double(Core::ArticleReader, call: article) }
    let(:category_parent_reader) { double(Core::CategoryParentsReader, call: parents) }

    context 'when an article does exist' do
      before do
        allow(Core::ArticleReader).to receive(:new) { article_reader }
        allow(Core::CategoryParentsReader).to receive(:new) { category_parent_reader }
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

      context 'when an article belongs to one category' do
        let(:category) { double }
        let(:categories) { [category] }
        let(:parents) { [double] }

        it 'assigns category hierarchy' do
          get :show, locale: I18n.locale, id: article.id

          expect(assigns(:category_hierarchy)).to eq(parents + [category])
        end

        specify "category hierarchy contains article's category" do
          get :show, locale: I18n.locale, id: article.id

          expect(assigns(:category_hierarchy)).to include(category)
        end
      end

      context 'when an article belongs to many categories' do
        let(:categories) { [double, double] }

        it 'category hierarchy is empty' do
          get :show, locale: I18n.locale, id: article.id

          expect(assigns(:category_hierarchy)).to eq([])
        end
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
