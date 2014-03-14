require 'spec_helper'
require_relative 'shared_examples/optional_failure_block'

require 'core/interactors/category_reader'
require 'core/repositories/categories/fake'

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

      context 'when the returned category contains sub-categories, action plans and articles' do
        let(:contents) { %w{article_hash action_plan_hash category_hash}.map(&method(:build)) }
        let(:repo_category) { build :category_hash, id: id, contents: contents }
        let(:repository) { Repositories::Categories::Fake.new(repo_category) }
        let(:category) { subject.call }

        before do
          allow(Registries::Repository).to receive(:[]).with(:category).and_return(repository)
        end

        [Article, ActionPlan, Category].each_with_index do |klass, i|
          specify { expect(category.contents[i]).to be_a(klass) }
        end
      end

      context 'when the returned category contains an unsupported entity' do
        let(:type) { 'unsupported' }
        let(:unsupported) { { 'type' => type, 'title' => 'Unsupported Content' } }
        let(:data) { build :category_hash, contents: [unsupported] }
        let(:category) { subject.call }

        specify { expect(category.contents.first).to be_a(Other) }
        specify { expect(category.contents.first.type).to eq(type) }
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
