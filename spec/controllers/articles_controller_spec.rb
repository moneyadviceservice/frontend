require 'spec_helper'
require 'core/interactors/article_reader'

describe ArticlesController do
  describe 'GET show' do
    let(:article) { double(Core::Article, id: 'test') }
    let(:article_reader) { double(Core::ArticleReader, call: article) }
    let(:filtered_categories) { double }

    context 'when an article does exist' do
      before do
        allow(Core::ArticleReader).to receive(:new) { article_reader }
        allow(controller).to receive(:filtered_related_categories) { filtered_categories }
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

      it 'calls #filtered_related_categories with the article' do
        expect(controller).to receive(:filtered_related_categories).with(article)

        get :show, locale: I18n.locale, id: article.id
      end

      it 'assigns the output of article#categpres to #filtered_related_categories' do
        get :show, locale: I18n.locale, id: article.id

        expect(assigns(:related_categories)).to eq(filtered_categories)
      end
    end

    context 'when an article does not exist' do
      it 'raises an ActionController RoutingError' do
        allow_any_instance_of(Core::ArticleReader).to receive(:call).and_yield

        expect{ get :show, id: 'foo', locale: I18n.locale }.to raise_error(ActionController::RoutingError)
      end
    end
  end

  describe '#filtered_related_categories' do
    let(:article_first_instance) { Core::Article.new('article A').tap { |a| a.categories = [category] } }
    let(:article_second_instance) { Core::Article.new('article A') }
    let(:second_article) { Core::Article.new('Article B') }
    let(:category) { Core::Category.new('test').tap { |c| c.contents = [article_second_instance, second_article] } }

    subject { controller.send(:filtered_related_categories, article_first_instance) }

    it "removes the original article from it's categories' contents" do
      expect(subject.first.contents).to_not include(article_second_instance)
    end

    context 'if a category has no contents' do
      let(:category) { Core::Category.new('test').tap { |c| c.contents = [article_second_instance] } }

      it 'is excluded from the results' do
        expect(subject).to_not include(category)
      end
    end
  end
end
