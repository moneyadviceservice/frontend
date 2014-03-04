require_relative '../spec_helper'
require 'core/interactors/searcher'

describe SearchResultsController do
  describe 'GET index' do
    let(:query) { 'query' }
    let(:search_results) { [double] }
    let(:searcher) { double(Core::Searcher) }

    before do
      allow(Core::Searcher).to receive(:new) { searcher }
      allow(searcher).to receive(:call) { search_results }
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

      it 'assigns the result of search reader to  @search_results' do
        get :index, locale: I18n.locale, query: query

        expect(assigns(:search_results)).to eq(search_results)
      end

      it 'is successful' do
        get :index, locale: I18n.locale, query: query

        expect(response).to be_ok
      end
    end

    context 'without a search term' do
      it 'does not instantiate an search reader' do
        expect(Core::Searcher).to_not receive(:new)

        get :index, locale: I18n.locale
      end

      it 'is successful' do
        get :index, locale: I18n.locale

        expect(response).to be_ok
      end
    end
  end
end
