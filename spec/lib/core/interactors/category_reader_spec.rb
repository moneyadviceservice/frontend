require 'spec_helper'
require_relative 'shared_examples/optional_failure_block'

require 'core/entities/category'
require 'core/interactors/category_reader'

module Core
  describe CategoryReader, '#call' do
    subject { described_class.new(id) }

    let(:id) { 'the-category' }

    before do
      allow(Registries::Repository).to receive(:[]).with(:category) do
        double(find: data)
      end
    end

    context 'when the repository returns no data' do
      let(:data) { nil }

      it_has_behavior 'optional failure block'
    end

    context 'when the repository returns some data' do
      let(:description) { 'The Category has a description' }
      let(:data) { { description: description } }

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
      let(:title) { 'The Category' }
      let(:description) { 'The Category has a description' }
      let(:contents) { [] }

      let(:data) do
        { title: title, description: description, contents: contents }
      end

      it "maps the category's `id' to the repositories' `id' value" do
        expect(Category).
          to receive(:new).with(id, kind_of(Hash)).and_call_original

        subject.call
      end

      %W(title description content).each do |attribute|
        it "maps the category's `#{attribute}' to the repositories' `#{attribute}' value" do
          expect(Category).to(receive(:new)) { |_, attributes|
            expect(attributes[attribute.to_sym]).to eq(send(attribute))
          }.and_call_original

          subject.call
        end
      end

      context 'when the Category entity is valid' do
        before do
          expect_any_instance_of(Category).to receive(:valid?) { true }
        end

        it 'returns a category' do
          expect(subject.call).to be_a(Category)
        end
      end

      context 'when the Category is invalid' do
        before do
          expect_any_instance_of(Category).to receive(:valid?) { false }
        end

        it_has_behavior 'optional failure block'
      end

      context 'when the returned category contains sub-categories' do
        let(:data) { build :category_hash, contents: build_list(:category_hash, 1) }
        let(:category) { subject.call }

        specify { expect(category.contents.first).to be_a(Category) }
      end

      context 'when the returned category has no contents' do
        let(:category) { subject.call }
        let(:data) do
          { title: title, description: description }
        end

        specify { expect(category).to be_a(Category) }
        specify { expect(category.contents).to be_empty }
      end
    end
  end
end
