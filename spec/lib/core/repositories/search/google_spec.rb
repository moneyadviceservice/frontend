require 'spec_helper'
require 'core/repositories/search/google'

describe Core::Repositories::Search::Google  do
  describe '#perform' do
    let(:url) { 'https://example.com/path/to/url' }
    let(:query) { 'tools' }
    let(:search_options) { "key=#{ENV['GOOGLE_API_KEY']}&cx=#{ENV['GOOGLE_API_CX']}&q=#{query}" }
    let(:status) { 200 }

    subject { described_class.new.perform(query) }

    before do
      connection = Core::ConnectionFactory.build(url)
      allow(Core::Registries::Connection).to receive(:[]).with(:google_api) { connection }
      stub_request(:get, "https://example.com/path/to/url/customsearch/v1?#{search_options}").
        to_return(status: status, body: body, headers: {})
    end

    context 'when there is an error' do
      let(:body) { nil }
      let(:status) { 500 }

      specify { expect { described_class.new.perform(query) }.to raise_error(described_class::RequestError) }
    end

    context 'when the request is successful' do
      let(:id) { 'action-plan-id' }
      let(:type) { 'action_plans' }
      let(:title) { 'The action plan' }
      let(:description) { 'Action plan description' }
      let(:link) { "https://www.moneyadviceservice.org.uk/en/#{type}/#{id}" }
      let(:reformatted_data) { subject.first }
      let(:body) do
          {
            "items"=>[
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
            ]
          }
      end

      it { should be_a(Array) }

      it 'maps the id correctly' do
        expect(reformatted_data[:id]).to eq(id)
      end

      it 'maps the type correctly' do
        expect(reformatted_data[:type]).to eq(type)
      end

      it 'maps the description correctly' do
        expect(reformatted_data[:description]).to eq(description)
      end

      context 'when response has no items' do
        let(:body) { {"kind"=>"customsearch#search" } }

        it { should be_a(Array) }
        it { should be_empty}
      end
    end
  end
end
