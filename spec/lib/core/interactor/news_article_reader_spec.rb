require_relative 'shared_examples/optional_failure_block'

module Core
  RSpec.describe NewsArticleReader do
    subject { described_class.new(id) }

    let(:id) { 'the-news-article' }

    describe '.call' do
      let(:repository_double) { double(find: data) }

      before do
        allow(Registry::Repository).to receive(:[]).with(:news_article) do
          repository_double
        end
      end

      context 'when the repository returns no data' do
        let(:data) { nil }

        it_has_behavior 'optional failure block'
      end

      context 'when the repository returns data' do
        let(:title) { 'The news article' }
        let(:description) { 'The description' }
        let(:body) { '<h1>The news article</h1><p>Lorem ipsum dolor sit amet</p>' }

        let(:data) do
          { title: title, description: description, body: body }
        end

        it 'instantiates the news article with the id and the attributes from the repository' do
          expect(NewsArticle).to receive(:new).with(id, data).and_call_original

          subject.call
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

      context 'when news article is a redirect' do
        let(:exception) do
          Core::Repository::CMS::Resource302Error.new('https://example.com')
        end

        let(:repository_double) do
          repo = double
          allow(repo).to receive(:find).and_raise(exception)
          repo
        end

        it 'raises an error' do
          expect { subject.call }.to raise_error LocalJumpError
        end

        it 'errors with status' do
          subject.call do |error|
            expect(error.status).to eql(302)
          end
        end

        it 'errors with location' do
          subject.call do |error|
            expect(error.location).to eql('https://example.com')
          end
        end

        it 'errors as a redirect?' do
          subject.call do |error|
            expect(error.redirect?).to be_truthy
          end
        end
      end
    end
  end
end
