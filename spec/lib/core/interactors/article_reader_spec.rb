require 'spec_helper'

require 'core/entities/article'
require 'core/interactors/article_reader'

module Core
  describe ArticleReader do
    subject { described_class.new(id) }

    let(:id) { 'the-article' }

    describe '.call' do
      before do
        allow(RepositoryRegistry).to receive(:[]).with(:article) do
          double(find: data)
        end
      end

      context 'when the repository returns no data' do
        let(:data) { nil }


        context 'when a block is given' do
          let(:probe) { lambda {} }

          it 'calls the block' do
            expect(probe).to receive(:call)

            subject.call(&probe)
          end
        end

        context 'when no block is given' do
          it 'returns nil' do
            expect(subject.call).to be_nil
          end
        end
      end

      context 'when the repository returns data' do
        let(:url) { 'https://example.com/the-article' }
        let(:title) { 'The Article' }
        let(:description) { 'The Article has a description' }
        let(:body) { '<h1>The Article</h1><p>Lorem ipsum dolor sit amet</p>' }

        let(:data) do
          { url: url, title: title, description: description, body: body }
        end

        it "maps the article's `id' to the repositories' `id' value" do
          expect(Article).
            to receive(:new).with(id, kind_of(Hash))

          subject.call
        end

        %W(url title description body).each do |attribute|
          it "maps the article's `#{attribute}' to the repositories' `#{attribute}' value" do
            expect(Article).to receive(:new) do |_, attributes|
              expect(attributes[attribute.to_sym]).to eq(send(attribute))
            end

            subject.call
          end
        end

        it 'returns an article' do
          expect(subject.call).to be_a(Article)
        end
      end
    end
  end
end
