require_relative 'shared_examples/optional_failure_block'

module Core
  RSpec.describe VideoPreviewer do
    subject(:previewer) { described_class.new(id) }

    let(:id) { 'the-video' }

    describe 'call' do
      before do
        allow(Registry::Repository).to receive(:[]).with(:preview) do
          double(find: data)
        end
      end

      let(:title) { 'The Video' }
      let(:body)  { '<h1>The Video</h1><p>Lorem ipsum dolor sit amet</p>' }
      let(:categories) { [] }

      let(:data) do
        { title: title, body: body, categories: categories }
      end

      context 'when the video is valid' do
        before do
          expect_any_instance_of(Video).to receive(:valid?) { true }
        end

        it 'returns an video' do
          expect(previewer.call).to be_an(Video)
        end

        context 'with categories' do
          let(:categories) { %w(money budget) }

          it 'builds categories' do
            expect(previewer).to receive(:build_categories).with(categories) { double }

            previewer.call
          end
        end
      end

      context 'when the video is invalid' do
        before do
          expect_any_instance_of(Video).to receive(:valid?) { false }
        end

        it_has_behavior 'optional failure block'
      end
    end
  end
end
