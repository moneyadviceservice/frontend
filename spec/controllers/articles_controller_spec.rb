require 'spec_helper'
require 'core/interactors/breadcrumbs_reader'
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

        allow_any_instance_of(Core::BreadcrumbsReader).to receive(:call) { breadcrumbs }
      end

      it 'is successful' do
        get :show, id: article.id, locale: I18n.locale

        expect(response).to be_ok
      end

      it 'assigns the result of article reader to @article' do
        get :show, id: article.id, locale: I18n.locale

        expect(assigns(:article)).to eq(article)
      end

      context 'when the article belongs to one category' do
        let(:category) { Core::Category.new('a-category') }
        let(:categories) { [category] }

        it 'reads the breadcrumbs for the category' do
          expect(Core::BreadcrumbsReader).
            to receive(:new).with(category.id, category_tree).and_call_original

          get :show, id: article.id, locale: I18n.locale
        end

        it 'assigns the breadcrumbs to @breadcrumb_trails' do
          get :show, id: article.id, locale: I18n.locale

          expect(assigns(:breadcrumb_trails)).to eq([breadcrumbs])
        end
      end

      context 'when the article belongs to many categories' do
        let(:first_category) { Core::Category.new('a-category') }
        let(:second_category) { Core::Category.new('b-category') }
        let(:categories) { [first_category, second_category] }

        it 'reads the breadcrumbs for both categories' do
          expect(Core::BreadcrumbsReader).
            to receive(:new).with(first_category.id, category_tree).and_call_original
          expect(Core::BreadcrumbsReader).
            to receive(:new).with(second_category.id, category_tree).and_call_original

          get :show, id: article.id, locale: I18n.locale
        end

        it 'assigns the breadcrumbs to @breadcrumb_trails' do
          allow(Core::BreadcrumbsReader).
            to receive(:new).with(first_category.id, anything) { double(call: %w(a b c)) }

          allow(Core::BreadcrumbsReader).
            to receive(:new).with(second_category.id, anything) { double(call: %w(x y z)) }

          get :show, id: article.id, locale: I18n.locale

          expect(assigns(:breadcrumb_trails)).
            to eq([%w(a b c) << first_category, %w(x y z) << second_category])
        end
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
