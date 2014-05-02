require 'spec_helper'
require 'core/repositories/search/google_custom_search_engine/response_mapper'

describe Core::Repositories::Search::GoogleCustomSearchEngine::ResponseMapper do

  describe '#mapped_response' do
    let(:total_results) { 30 }
    let(:count) { 10 }
    let(:start_index) { 1 }

    let(:body) do
      {
        'queries' => {
          'request' => [
            'totalResults' => total_results.to_s,
            'count' => count.to_s,
            'startIndex' => start_index.to_s
          ]
        }
      }
    end

    let(:response) { double(body: body)}
    subject { described_class.new(response).mapped_response }

    describe 'the body attributes' do
      it 'maps the total results correctly' do
        expect(subject[:total_results]).to eq(total_results)
      end

      it 'maps the per page attribute correctly' do
        expect(subject[:per_page]).to eq(count)
      end

      context 'when on the first page' do
        it 'calculates the page number correctly' do
          expect(subject[:page]).to eq 1
        end
      end

      context 'when on the second page' do
        let(:start_index) { 11 }

        it 'calculates the page number correctly' do
          expect(subject[:page]).to eq 2
        end
      end
    end

    describe 'items' do
      let(:id) { 'action-plan-id' }
      let(:type) { 'action_plan' }
      let(:title) { 'The action plan' }
      let(:description) { 'Action plan description' }
      let(:link) { "https://www.moneyadviceservice.org.uk/en/#{type.pluralize}/#{id}" }
      let(:item) do
        {
         'link' => link,
         'title' => title,
         'pagemap' => {
            'metatags' => [
               {
                  'csrf-param' => 'authenticity_token',
                  'og:description' => description
               }
            ]
          }
        }
      end

      before { body['items'] = [item] }

      it 'maps the id correctly' do
        expect(subject[:items].first[:id]).to eq(id)
      end

      it 'maps the type correctly' do
        expect(subject[:items].first[:type]).to eq(type)
      end

      it 'maps the description correctly' do
        expect(subject[:items].first[:description]).to eq(description)
      end

      context 'when a response has none' do
        before { body['items'] = [] }

        it 'returns an empty array' do
          expect(subject[:items]).to be_a(Array)
          expect(subject[:items]).to be_empty
        end
      end

      context "when it doesn't have pagemap" do
        let(:item) { { 'link' => link, 'title' => title } }

        it 'maps the description to empty string' do
          expect(subject[:items].first[:description]).to be_empty
        end
      end

      context "when it doesn't have metatags" do
        let(:item) { { "link"=>link, "title"=>title, "pagemap"=>{} } }

        it 'maps the description to empty string' do
          expect(subject[:items].first[:description]).to be_empty
        end
      end
    end
  end
end
