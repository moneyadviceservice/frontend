require 'spec_helper'
require 'core/repositories/search/google_custom_search_engine_response_mapper'

describe Core::Repositories::Search::GoogleCustomSearchEngineResponseMapper do

  describe '#map' do
    let(:id) { 'action-plan-id' }
    let(:type) { 'action_plan' }
    let(:title) { 'The action plan' }
    let(:description) { 'Action plan description' }
    let(:link) { "https://www.moneyadviceservice.org.uk/en/#{type.pluralize}/#{id}" }
    let(:item) do
      {
       "link"=>link,
       "title"=>title,
       "pagemap"=>{
          "metatags"=>[
             {
                "csrf-param"=>"authenticity_token",
                "og:description"=>description
             }
          ]
        }
      }
    end
    let(:response) { double(body: { 'items' => [item] })}

    subject(:mapped_response) { described_class.new.map(response) }

    it 'maps the id correctly' do
      expect(mapped_response.first[:id]).to eq(id)
    end

    it 'maps the type correctly' do
      expect(mapped_response.first[:type]).to eq(type)
    end

    it 'maps the description correctly' do
      expect(mapped_response.first[:description]).to eq(description)
    end

    context 'when response has no items' do
      let(:response) { double(body: { "kind"=>"customsearch#search" }) }

      it 'returns an emty array' do
        expect(mapped_response).to be_a(Array)
        expect(mapped_response).to be_empty
      end
    end

    context "when item doesn't have pagemap" do
      let(:item) { { "link"=>link, "title"=>title } }

      it 'maps the description to empty string' do
        expect(mapped_response.first[:description]).to be_empty
      end
    end

    context "when item doesn't have metatags" do
      let(:item) { { "link"=>link, "title"=>title, "pagemap"=>{} } }

      it 'maps the description to empty string' do
        expect(mapped_response.first[:description]).to be_empty
      end
    end
  end
end
