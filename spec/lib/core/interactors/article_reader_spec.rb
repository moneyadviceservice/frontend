require 'spec_helper'

require 'core/entities/article'
require 'core/interactors/article_reader'

shared_examples_for 'optional failure block' do
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

        it_has_behavior 'optional failure block'
      end

      context 'when the repository returns some data' do
        let(:title) { 'The Article' }
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
        let(:title) { 'The Article' }
        let(:description) { 'The Article has a description' }
        let(:body) { '<h1>The Article</h1><p>Lorem ipsum dolor sit amet</p>' }

        let(:data) do
          { title: title, description: description, body: body }
        end

        it "maps the article's `id' to the repositories' `id' value" do
          expect(Article).
            to receive(:new).with(id, kind_of(Hash)).and_call_original

          subject.call
        end

        %W(title description body).each do |attribute|
          it "maps the article's `#{attribute}' to the repositories' `#{attribute}' value" do
            expect(Article).to(receive(:new)) { |_, attributes|
              expect(attributes[attribute.to_sym]).to eq(send(attribute))
            }.and_call_original

            subject.call
          end
        end

        context 'when the Article entity is valid' do
          before do
            expect_any_instance_of(Article).to receive(:valid?) { true }
          end

          it 'returns an article' do
            expect(subject.call).to be_a(Article)
          end
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
end
