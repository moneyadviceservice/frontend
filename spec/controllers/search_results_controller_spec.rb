require_relative '../spec_helper'
require 'core/interactors/searcher'

describe SearchResultsController do
  describe 'GET index' do
    let(:query) { 'query' }
    let(:search_results) { [double] }
    let(:search_results_collection) { double(items: search_results) }
    let(:searcher) { double(Core::Searcher) }

    before do
      allow(Core::Searcher).to receive(:new) { searcher }
      allow(searcher).to receive(:call) { search_results_collection }
      allow(search_results_collection).to receive(:any?)
    end

    context 'with a search term' do
      it 'instantiates an search reader' do
        expect(Core::Searcher).to receive(:new).with(query)

        get :index, locale: I18n.locale, query: query
      end

      it 'calls the search reader' do
        expect(searcher).to receive(:call)

        get :index, locale: I18n.locale, query: query
      end

      context 'that returns results' do
        before { allow(search_results_collection).to receive(:any?).and_return(true) }

        it "assigns the result of the search reader's items to @search_results" do
          get :index, locale: I18n.locale, query: query

          expect(assigns(:search_results)).to eq(search_results)
        end

        it 'renders the right template' do
          get :index, locale: I18n.locale, query: query

          expect(response).to render_template 'search_results/index_with_results'
        end
      end

      context 'that returns no results' do
        before { allow(search_results_collection).to receive(:any?).and_return(false) }

        it 'renders the right template' do
          get :index, locale: I18n.locale, query: query

          expect(response).to render_template 'search_results/index_no_results'
        end
      end
    end

    context 'without a search term' do
      it 'does not instantiate an search reader' do
        expect(Core::Searcher).to_not receive(:new)

        get :index, locale: I18n.locale
      end

      it 'renders the default template' do
        get :index, locale: I18n.locale

        expect(response).to render_template :index
      end
    end
  end
end
