require_relative 'shared_examples/optional_failure_block'

module Core
  RSpec.describe VideoReader do
    subject { described_class.new(id) }

    let(:id) { 'the-video' }

    describe '.call' do
      before do
        allow(Registry::Repository).to receive(:[]).with(:video) do
          double(find: data)
        end
      end

      context 'when the repository returns no data' do
        let(:data) { nil }

        it_has_behavior 'optional failure block'
      end

      context 'when the repository returns data' do
        let(:title) { 'The Video' }
        let(:description) { 'The Video has a description' }
        let(:body) { '<h1>The Video</h1><p>Lorem ipsum dolor sit amet</p>' }
        let(:categories) { [] }

        let(:data) do
          { title: title, description: description, body: body, categories: categories }
        end

        it 'instantiates the video with the id and the attributes from the repository' do
          expect(Video)
            .to receive(:new).with(id, data).and_call_original

          subject.call
        end

        context 'when the Video is invalid' do
          let(:video) { double(Video) }

          before do
            allow(Video).to receive(:new) { video }
            allow(video).to receive(:valid?) { false }
          end

          it_has_behavior 'optional failure block'
        end

        context 'when there is a category' do
          let(:category) { 'foo' }
          let(:categories) { [category] }
          let(:category_entity) { double }
          let(:category_reader) { double }

          before do
            allow(CategoryReader).to receive(:new) { category_reader }
            allow(category_reader).to receive(:call) { category_entity }
          end

          it 'returns the category reader results' do
            expect(subject.call.categories).to eql [category_entity]
          end
        end
      end
    end
  end
end
