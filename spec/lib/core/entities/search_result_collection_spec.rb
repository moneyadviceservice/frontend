require 'spec_helper'
require 'core/entities/search_result_collection'

module Core
  describe SearchResultCollection do
    let(:items) { [] }
    let(:attributes) { { items: items } }
    subject(:result_collection) { described_class.new(double, attributes) }

    it { should respond_to :items }
    it { should respond_to :items= }

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

    describe '#page' do
      let(:number_of_pages) { 10 }

      before do
        allow(subject).to receive(:number_of_pages) { number_of_pages }
        subject.page = page
      end

      context 'when the requested page number is less than the total number of pages' do
        let(:page) {  5 }

        it 'returns the original requested page number' do
          expect(subject.page).to eq page
        end
      end

      context 'when the requested page number is more than the total number of pages' do
        let(:page) {  15 }

        it 'returns the total number of pages' do
          expect(subject.page).to eq number_of_pages
        end
      end
    end

    describe '#total_results' do
      let(:result_limit) { 50 }

      before do
        allow(subject).to receive(:result_limit) { result_limit }
        subject.total_results = total_results
      end

      context 'when the total number of results is less than the result limit' do
        let(:total_results) {  40 }

        it 'returns the actual number of results' do
          expect(subject.total_results).to eq total_results
        end
      end

      context 'when the total number of results is more than the result limit' do
        let(:total_results) {  100 }

        it 'returns the result limit' do
          expect(subject.total_results).to eq result_limit
        end
      end
    end

    describe '#any?' do
      subject { result_collection.any? }

      context 'when items are present' do
        let(:items) { [double] }
        it { should be_true }
      end

      context 'when items are not present' do
        it { should be_false }
      end
    end

    context 'with 5 pages of 10 results' do
      let(:collection) { described_class.new(double) }

      before do
        collection.per_page = 10
        collection.total_results = 50
      end

      describe '#first_page?' do
        subject { collection.first_page? }

        context 'when the current page is 1' do
          before { collection.page = 1 }
          it { should be_true }
        end

        context 'when the current page is 3' do
          before { collection.page = 3 }
          it { should be_false }
        end

        context 'when the current page is 5' do
          before { collection.page = 5 }
          it { should be_false }
        end
      end

      describe '#last_page?' do
        subject { collection.last_page? }

        context 'when the current page is 1' do
          before { collection.page = 1 }
          it { should be_false }
        end

        context 'when the current page is 3' do
          before { collection.page = 3 }
          it { should be_false }
        end

        context 'when the current page is 5' do
          before { collection.page = 5 }
          it { should be_true }
        end
      end

      describe '#previous_page' do
        subject { collection.previous_page }

        context 'when the current page is 1' do
          before { collection.page = 1 }
          it { should be_nil }
        end

        context 'when the current page is 3' do
          before { collection.page = 3 }
          it { should eql 2 }
        end

        context 'when the current page is 5' do
          before { collection.page = 5 }
          it { should eql 4 }
        end
      end

      describe '#next_page' do
        subject { collection.next_page }

        context 'when the current page is 1' do
          before { collection.page = 1 }
          it { should eql 2 }
        end

        context 'when the current page is 3' do
          before { collection.page = 3 }
          it { should eql 4 }
        end

        context 'when the current page is 5' do
          before { collection.page = 5 }
          it { should be_nil }
        end
      end
    end

    describe '#number_of_pages' do
      let(:collection) { described_class.new(double) }
      subject { collection.number_of_pages }

      context 'with 10 results per page' do
        before { collection.per_page = 10 }

        context 'and a total of 20 results' do
          before { collection.total_results = 20 }
          it { should eql 2 }
        end

        context 'and a total of 15 results' do
          before { collection.total_results = 15 }
          it { should eql 2 }
        end

        context 'and a total of 10 results' do
          before { collection.total_results = 10 }
          it { should eql 1 }
        end

        context 'and a total of 5 results' do
          before { collection.total_results = 5 }
          it { should eql 1 }
        end

        context 'and zero results' do
          before { collection.total_results = 0 }
          it { should eql 1 }
        end
      end
    end
  end
end
