require_relative 'shared_examples/optional_failure_block'

module Core
  RSpec.describe CategoryReader, '#call' do
    subject { described_class.new(id) }

    let(:id) { 'the-category' }
    let(:repository_double) { double(find: data) }

    before do
      allow(Registry::Repository).to receive(:[]).with(:category) do
        repository_double
      end
    end

    context 'when the repository returns no data' do
      let(:data) { nil }

      it_has_behavior 'optional failure block'
    end

    context 'when the repository returns data' do
      let(:title) { 'The Category' }
      let(:description) { 'The Category has a description' }
      let(:contents) { [] }

      let(:data) do
        { title: title, description: description, contents: contents }
      end

      it 'instantiates the category with the id and the attributes from the repository' do
        expect(Category)
          .to receive(:new).with(id, data).and_call_original

        subject.call
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
        let(:contents) { %w(article_hash action_plan_hash category_hash).map(&method(:build)) }
        let(:repo_category) { build :category_hash, id: id, contents: contents }
        let(:repository) { Repository::Categories::Fake.new(repo_category) }
        let(:category) { subject.call }

        before do
          allow(Registry::Repository).to receive(:[]).with(:category).and_return(repository)
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

      context 'when `legacy_contents` is provided' do
        let(:legacy_contents) { %w(article_hash action_plan_hash).map(&method(:build)) }
        let(:repo_category) { build :category_hash, id: id, legacy_contents: legacy_contents }
        let(:repository) { Repository::Categories::Fake.new(repo_category) }
        let(:category) { subject.call }

        before do
          allow(Registry::Repository).to receive(:[]).with(:category).and_return(repository)
        end

        [Article, ActionPlan].each_with_index do |klass, i|
          it "loads class #{klass}" do
            expect(category.legacy_contents[i]).to be_a(klass)
          end
        end
      end
    end

    context 'when category is redirected' do
      let(:repository_double) do
        repo = double
        allow(repo).to receive(:find).and_raise(Core::Repository::CMS::Resource301Error.new('https://example.com'))
        repo
      end

      it 'returns a redirect' do
        subject.call do |redirect|
          expect(redirect.redirect?).to be_truthy
          expect(redirect.status).to eql(301)
          expect(redirect.location).to eql('https://example.com')
        end
      end
    end
  end
end
