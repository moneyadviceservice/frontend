require_relative 'shared_examples/optional_failure_block'

require 'core/interactors/news_article_reader'
require 'core/entities/news_article'

module Core
  RSpec.describe NewsArticleReader do
    subject { described_class.new(id) }

    let(:id) { 'the-news-article' }

    describe '.call' do
      before do
        allow(Registries::Repository).to receive(:[]).with(:news) do
          double(find: data)
        end
      end

      context 'when the repository returns no data' do
        let(:data) { nil }

        it_has_behavior 'optional failure block'
      end

      context 'when the repository returns some data' do
        let(:title) { 'The article' }
        let(:data) { { title: title } }

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
        let(:title) { 'The news article' }
        let(:description) { 'The description' }
        let(:body) { '<h1>The news article</h1><p>Lorem ipsum dolor sit amet</p>'}

        let(:data) do
          { title: title, description: description, body: body }
        end

        it "maps the news article's 'id' to the repositories 'id' value" do
          expect(NewsArticle).to receive(:new).with(id, kind_of(Hash)).and_call_original

          subject.call
        end

        %w(title description body).each do |attribute|
          it "maps the article's '#{attribute}'' to the repositories '#{attribute}' value" do
            expect(NewsArticle).to receive(:new) do |_, attributes|
              expect(attributes[attribute.to_sym].to eq(send(attribute)))
            end.and_call_original

            subject.call
          end
        end

        context 'when the News Article entity is valid' do
          before do
            expect_any_instance_of(NewsArticle).to receive(:valid?).and_return(true)
          end

          it 'returns a News Article' do
            expect(subject.call).to be_a(NewsArticle)
          end
        end

        context 'when the News Article entity is invalid' do
          before do
            expect_any_instance_of(NewsArticle).to receive(:valid?).and_return(false)
          end

          it_has_behavior 'optional failure block'
        end
      end
    end
  end
end
