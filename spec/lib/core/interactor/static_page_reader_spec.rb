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

      context 'when the repository returns some data' do
        let(:title) { 'The StaticPage' }
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
        let(:title) { 'The StaticPage' }
        let(:description) { 'The StaticPage has a description' }
        let(:body) { '<h1>The StaticPage</h1><p>Lorem ipsum dolor sit amet</p>' }
        let(:categories) { [] }

        let(:data) do
          { title: title, description: description, body: body, categories: categories }
        end

        it "maps the static_page's `id' to the repositories' `id' value" do
          expect(StaticPage).
            to receive(:new).with(id, kind_of(Hash)).and_call_original

          subject.call
        end

        %W(title description body).each do |attribute|
          it "maps the static_page's `#{attribute}' to the repositories' `#{attribute}' value" do
            expect(StaticPage).to(receive(:new)) { |_, attributes|
              expect(attributes[attribute.to_sym]).to eq(send(attribute))
            }.and_call_original

            subject.call
          end
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
