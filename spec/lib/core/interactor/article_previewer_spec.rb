require_relative 'shared_examples/optional_failure_block'

module Core
  RSpec.describe ArticlePreviewer do
    subject { described_class.new(id) }

    let(:id) { 'the-article' }

    describe 'call' do
      before do
        allow(Registry::Repository).to receive(:[]).with(:preview) do
          double(find: data)
        end
      end

      let(:title) { 'The Article' }
      let(:body)  { '<h1>The Article</h1><p>Lorem ipsum dolor sit amet</p>' }

      let(:data) do
        { title: title, body: body }
      end

      context 'when the Article is valid' do
        before do
          expect_any_instance_of(Article).to receive(:valid?) { true }
        end

        specify { expect(subject.call).to be_an(Article) }
      end

      context 'when the Article is invalid' do
        before do
          expect_any_instance_of(Article).to receive(:valid?) { false }
        end

        it_has_behavior 'optional failure block'
      end
    end
  end
end
