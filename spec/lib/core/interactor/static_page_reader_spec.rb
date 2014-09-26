require_relative 'shared_examples/optional_failure_block'

module Core
  RSpec.describe StaticPageReader do
    subject { described_class.new(id) }

    let(:id) { 'the-static_page' }

    describe '.call' do
      before do
        allow(Registry::Repository).to receive(:[]).with(:static_page) do
          double(find: data)
        end
      end

      context 'when the repository returns no data' do
        let(:data) { nil }

        it_has_behavior 'optional failure block'
      end

      context 'when the repository returns data' do
        let(:title) { 'The StaticPage' }
        let(:description) { 'The StaticPage has a description' }
        let(:body) { '<h1>The StaticPage</h1><p>Lorem ipsum dolor sit amet</p>' }
        let(:categories) { [] }

        let(:data) do
          { title: title, description: description, body: body, categories: categories }
        end

        it 'instantiates the static page with the id and the attributes from the repository' do
          expect(StaticPage).
            to receive(:new).with(id, data).and_call_original

          subject.call
        end

        context 'when the StaticPage entity is valid' do
          before do
            expect_any_instance_of(StaticPage).to receive(:valid?) { true }
          end

          it 'returns an static_page' do
            expect(subject.call).to be_a(StaticPage)
          end
        end

        context 'when the StaticPage is invalid' do
          before do
            expect_any_instance_of(StaticPage).to receive(:valid?) { false }
          end

          it_has_behavior 'optional failure block'
        end
      end
    end
  end
end
