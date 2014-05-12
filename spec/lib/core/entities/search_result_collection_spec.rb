require 'spec_helper'
require 'core/entities/search_result_collection'

module Core
  describe SearchResultCollection do
    let(:items) { [] }
    let(:attributes) { { items: items } }
    subject(:result_collection) { described_class.new(double, attributes) }

    it { should respond_to :query }
    it { should respond_to :query= }

    it { should respond_to :total_results }
    it { should respond_to :total_results= }

    it { should respond_to :page }
    it { should respond_to :page= }

    it { should respond_to :per_page }
    it { should respond_to :per_page= }

    describe '#items' do
      it 'is an empty array by default' do
        expect(subject.items).to be_kind_of(Array)
        expect(subject.items).to be_empty
      end
    end
  end
end
