require 'spec_helper'
require 'core/entities/article'

module Core
  describe Article do
    subject { described_class.new(double, attributes) }

    let(:attributes) do
      { title:       double,
        description: double,
        body:        double,
        alternate:   { title: double, url: double, hreflang: double } }
    end

    it { should respond_to :title }
    it { should respond_to :title= }

    it { should respond_to :description }
    it { should respond_to :description= }

    it { should respond_to :body }
    it { should respond_to :body= }

    it { should respond_to :alternate }
    it { should respond_to :alternate= }

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }

    its(:alternate) { should be_a(Article::Alternate) }

    describe '#alternate=' do
        let(:alternate_title) { 'title' }
        let(:url) { 'www.example.com' }
        let(:hreflang) { 'cy' }

        before { subject.alternate=({ title: alternate_title, url: url, hreflang: hreflang }) }

        it 'assigns alternate title' do
          expect(subject.alternate.title).to eq(alternate_title)
        end

        it 'assigns alternate url' do
          expect(subject.alternate.url).to eq(url)
        end

        it 'assigns alternate hreflang' do
            expect(subject.alternate.hreflang).to eq(hreflang)
        end
    end
  end
end
