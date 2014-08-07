require_relative 'shared_examples/optional_failure_block'

module Core
  RSpec.describe ArticlePreviewer do
    subject(:previewer) { described_class.new(id) }

    let(:id) { 'the-article' }

    describe 'call' do
      before do
        allow(Registry::Repository).to receive(:[]).with(:preview) do
          double(find: data)
        end
      end

      let(:title) { 'The Article' }
      let(:body)  { '<h1>The Article</h1><p>Lorem ipsum dolor sit amet</p>' }
      let(:categories) { [] }

      let(:data) do
        { title: title, body: body, categories: categories }
      end

      context 'when the article is valid' do
        before do
          expect_any_instance_of(Article).to receive(:valid?) { true }
        end

        it 'returns an article' do
          expect(previewer.call).to be_an(Article)
        end

        context 'with categories' do
          let(:categories) { ['money', 'budget'] }

          it 'builds categories' do
            expect(previewer).to receive(:build_categories).with(categories) { double }

            previewer.call
          end
        end
      end

      context 'when the article is invalid' do
        before do
          expect_any_instance_of(Article).to receive(:valid?) { false }
        end

        it_has_behavior 'optional failure block'
      end
    end
  end
end
