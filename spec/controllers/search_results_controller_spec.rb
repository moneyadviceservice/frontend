RSpec.describe SearchResultsController, type: :controller do
  describe 'GET index' do
    let(:query) { 'query' }
    let(:search_results_collection) { double(any?: true) }

    context 'with a search term' do
      before do
        expect_any_instance_of(SiteSearch::Query).to receive(:results)
          .and_return(search_results_collection)
      end

      context 'that returns results' do
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
        before { allow(search_results_collection).to receive(:any?) { false } }

        it 'renders the right template' do
          get :index, locale: I18n.locale, query: query

          expect(response).to render_template 'search_results/index_no_results'
        end
      end
    end

    context 'without a search term' do
      it 'does not search' do
        expect_any_instance_of(SiteSearch::Query).to_not receive(:results)
          .and_return(search_results_collection)

        get :index, locale: I18n.locale
      end

      it 'renders the default template' do
        get :index, locale: I18n.locale

        expect(response).to render_template :index
      end
    end
  end
end
