require_relative '../spec_helper'
require 'core/interactors/searcher'

RSpec.describe SearchResultsController, :type => :controller do
  describe 'GET index' do
    let(:query) { 'query' }
    let(:search_results) { [double] }
    let(:search_results_collection) { double(items: search_results) }
    let(:searcher) { instance_double(Core::Searcher) }

    before do
      allow(Core::Searcher).to receive(:new) { searcher }
      allow(searcher).to receive(:call) { search_results_collection }
    end

    context 'with a search term' do
      context 'with no page param' do
        it 'instantiates a search reader with a nil page option' do
          expect(Core::Searcher).to receive(:new).with(query, page: nil)

          get :index, locale: I18n.locale, query: query
        end
      end

      context 'with a page param' do
        let(:page) { '10' }

        it 'instantiates a search reader with the param page option' do
          expect(Core::Searcher).to receive(:new).with(query, page: page)

          get :index, locale: I18n.locale, query: query, page: page
        end
      end

      it 'calls the search reader' do
        expect(searcher).to receive(:call)

        get :index, locale: I18n.locale, query: query
      end

      context 'that returns results' do
        before { allow(search_results_collection).to receive(:any?).and_return(true) }

        it 'assigns the result of the search reader to @search_results' do
          get :index, locale: I18n.locale, query: query

          expect(assigns(:search_results)).to eq(search_results_collection)
        end

        it 'renders the right template' do
          get :index, locale: I18n.locale, query: query

          expect(response).to render_template 'search_results/index_with_results'
        end
      end

      context 'that returns no results' do
        before { allow(search_results_collection).to receive(:items) { []} }

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
