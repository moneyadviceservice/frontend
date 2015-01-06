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

        context 'when the Video entity is valid' do
          before do
            expect_any_instance_of(Video).to receive(:valid?) { true }
          end

          it 'returns an Video' do
            expect(subject.call).to be_a(Video)
          end
        end

        context 'when the Video is invalid' do
          before do
            expect_any_instance_of(Video).to receive(:valid?) { false }
          end

          it_has_behavior 'optional failure block'
        end

        context 'when there is a category' do
          let(:category) { 'foo' }
          let(:categories) { [category] }
          let(:category_entity) { double }

          before do
            allow_any_instance_of(CategoryReader).to receive(:call) { category_entity }
          end

          it 'instantiates a category reader with the category' do
            expect(CategoryReader).to receive(:new).with(category).and_call_original
            subject.call
          end

          it 'calls the category reader' do
            expect_any_instance_of(CategoryReader).to receive(:call)
            subject.call
          end

          it 'returns the category reader results' do
            expect(subject.call.categories).to eql [category_entity]
          end
        end
      end
    end
  end
end
