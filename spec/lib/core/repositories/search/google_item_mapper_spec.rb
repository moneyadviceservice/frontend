require 'spec_helper'
require 'core/repositories/search/google_item_mapper'

describe Core::Repositories::Search::GoogleItemMapper do

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

    subject(:mapped_item) { described_class.new.map(item) }

    it 'maps the id correctly' do
        expect(mapped_item[:id]).to eq(id)
      end

    it 'maps the type correctly' do
      expect(mapped_item[:type]).to eq(type)
    end

    it 'maps the description correctly' do
      expect(mapped_item[:description]).to eq(description)
    end
  end
end
