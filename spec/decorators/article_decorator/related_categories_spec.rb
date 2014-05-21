require 'spec_helper'
require 'core/entities/article'

RSpec.describe ArticleDecorator do
  let(:parent_article) { double('parent article', id: 'parent-article') }
  let(:article_1) { double('article 1', id: 'article-1') }
  let(:article_2) { double('article 2', id: 'article-2') }
  let(:article_3) { double('article 3', id: 'article-3') }
  let(:article_4) { double('article 4', id: 'article-4') }
  let(:article_5) { double('article 5', id: 'article-5') }

  let(:decorator) { described_class.decorate(parent_article) }
  let(:qty) { 4 }
  let(:related_categories) { decorator.related_categories(qty) }

  describe '#related_categories' do
    context 'with one parent category' do
      let(:contents) { [article_1] }
      let(:category) { double('category', id: 'category', contents: contents) }
      let(:categories) { [category] }

      before do
        allow(parent_article).to receive(:categories) { categories }
      end

      context 'there is an entry with the decorated category for a key' do
        subject { related_categories.keys.first }

        it { is_expected.to be_a_decorated_version_of(category).decorated_with(CategoryDecorator) }
      end

      context 'when the category has one other item in it' do
        let(:contents) { [article_1] }

        context 'the value' do
          subject { related_categories.values.first }

          it { is_expected.to be_a_decorated_version_of(contents).decorated_with(CategoryContentDecorator) }
        end
      end

      context 'when the category has two other items in it' do
        let(:contents) { [article_1, article_2] }

        context 'the value' do
          subject { related_categories.values.first }

          it { is_expected.to be_a_decorated_version_of(contents).decorated_with(CategoryContentDecorator) }
        end
      end

      context 'when the category has three other items in it' do
        let(:contents) { [article_1, article_2, article_3] }

        context 'the value' do
          subject { related_categories.values.first }

          it { is_expected.to be_a_decorated_version_of(contents).decorated_with(CategoryContentDecorator) }
        end
      end

      context 'when the category has four other items in it' do
        let(:contents) { [article_1, article_2, article_3, article_4] }

        context 'the value' do
          subject { related_categories.values.first }

          it { is_expected.to be_a_decorated_version_of(contents).decorated_with(CategoryContentDecorator) }
        end
      end

      context 'when the category has five other items in it' do
        let(:contents) { [article_1, article_2, article_3, article_4, article_5] }

        context 'the value' do
          let(:expected_contents) { [article_1, article_2, article_3, article_4] }
          subject { related_categories.values.first }

          it { is_expected.to be_a_decorated_version_of(expected_contents).decorated_with(CategoryContentDecorator) }
        end
      end

      context 'when one of the categories is the base category' do
        let(:contents) { [article_1, parent_article, article_2] }

        context 'the value' do
          let(:expected_contents) { [article_1, article_2] }
          subject { related_categories.values.first }

          it { is_expected.to be_a_decorated_version_of(expected_contents).decorated_with(CategoryContentDecorator) }
        end
      end
    end

    context 'with two parent categories' do
      let(:contents_1) { [article_1] }
      let(:contents_2) { [article_2] }
      let(:category_1) { double('category 1', id: 'category-1', contents: contents_1) }
      let(:category_2) { double('category 2', id: 'category-2', contents: contents_2) }
      let(:categories) { [category_1, category_2] }
      let(:related_categories) { decorator.related_categories(qty) }

      before do
        allow(parent_article).to receive(:categories) { categories }
      end

      context 'there is an entry with the first decorated category for a key' do
        subject { related_categories.keys.first }

        it { is_expected.to be_a_decorated_version_of(category_1).decorated_with(CategoryDecorator) }
      end

      context 'there is an entry with the second decorated category for a key' do
        subject { related_categories.keys[1] }

        it { is_expected.to be_a_decorated_version_of(category_2).decorated_with(CategoryDecorator) }
      end

      context 'when the first category has one item in it' do
        let(:contents_1) { [article_1] }

        context 'and the second category has one item in it' do
          let(:contents_2) { [article_2] }

          context "the first category's value" do
            let(:expected_contents) { [article_1]}
            subject { related_categories.values.first }

            it { is_expected.to be_a_decorated_version_of(expected_contents).decorated_with(CategoryContentDecorator) }
          end

          context "the second category's value" do
            let(:expected_contents) { [article_2]}
            subject { related_categories.values[1] }

            it { is_expected.to be_a_decorated_version_of(expected_contents).decorated_with(CategoryContentDecorator) }
          end
        end

        context 'and the second category has two items in it' do
          let(:contents_2) { [article_2, article_3] }

          context "the first category's value" do
            let(:expected_contents) { [article_1]}
            subject { related_categories.values.first }

            it { is_expected.to be_a_decorated_version_of(expected_contents).decorated_with(CategoryContentDecorator) }
          end

          context "the second category's value" do
            let(:expected_contents) { [article_2, article_3]}
            subject { related_categories.values[1] }

            it { is_expected.to be_a_decorated_version_of(expected_contents).decorated_with(CategoryContentDecorator) }
          end
        end

        context 'and the second category has three items in it' do
          let(:contents_2) { [article_2, article_3, article_4] }

          context "the first category's value" do
            let(:expected_contents) { [article_1]}
            subject { related_categories.values.first }

            it { is_expected.to be_a_decorated_version_of(expected_contents).decorated_with(CategoryContentDecorator) }
          end

          context "the second category's value" do
            let(:expected_contents) { [article_2, article_3, article_4]}
            subject { related_categories.values[1] }

            it { is_expected.to be_a_decorated_version_of(expected_contents).decorated_with(CategoryContentDecorator) }
          end
        end

        context 'and the second category has four items in it' do
          let(:contents_2) { [article_2, article_3, article_4, article_5] }

          context "the first category's value" do
            let(:expected_contents) { [article_1]}
            subject { related_categories.values.first }

            it { is_expected.to be_a_decorated_version_of(expected_contents).decorated_with(CategoryContentDecorator) }
          end

          context "the second category's value" do
            let(:expected_contents) { [article_2, article_3, article_4]}
            subject { related_categories.values[1] }

            it { is_expected.to be_a_decorated_version_of(expected_contents).decorated_with(CategoryContentDecorator) }
          end
        end
      end

      context 'when the first category has two items in it' do
        let(:contents_1) { [article_1, article_2] }

        context 'and the second category has one item in it' do
          let(:contents_2) { [article_3] }

          context "the first category's value" do
            let(:expected_contents) { [article_1, article_2]}
            subject { related_categories.values.first }

            it { is_expected.to be_a_decorated_version_of(expected_contents).decorated_with(CategoryContentDecorator) }
          end

          context "the second category's value" do
            let(:expected_contents) { [article_3]}
            subject { related_categories.values[1] }

            it { is_expected.to be_a_decorated_version_of(expected_contents).decorated_with(CategoryContentDecorator) }
          end
        end

        context 'and the second category has two items in it' do
          let(:contents_2) { [article_3, article_4] }

          context "the first category's value" do
            let(:expected_contents) { [article_1, article_2]}
            subject { related_categories.values.first }

            it { is_expected.to be_a_decorated_version_of(expected_contents).decorated_with(CategoryContentDecorator) }
          end

          context "the second category's value" do
            let(:expected_contents) { [article_3, article_4]}
            subject { related_categories.values[1] }

            it { is_expected.to be_a_decorated_version_of(expected_contents).decorated_with(CategoryContentDecorator) }
          end
        end

        context 'and the second category has three items in it' do
          let(:contents_2) { [article_3, article_4, article_5] }

          context "the first category's value" do
            let(:expected_contents) { [article_1, article_2]}
            subject { related_categories.values.first }

            it { is_expected.to be_a_decorated_version_of(expected_contents).decorated_with(CategoryContentDecorator) }
          end

          context "the second category's value" do
            let(:expected_contents) { [article_3, article_4]}
            subject { related_categories.values[1] }

            it { is_expected.to be_a_decorated_version_of(expected_contents).decorated_with(CategoryContentDecorator) }
          end
        end
      end

      context 'when the first category has three items in it' do
        let(:contents_1) { [article_1, article_2, article_3] }

        context 'and the second category has one item in it' do
          let(:contents_2) { [article_4] }

          context "the first category's value" do
            let(:expected_contents) { [article_1, article_2, article_3]}
            subject { related_categories.values.first }

            it { is_expected.to be_a_decorated_version_of(expected_contents).decorated_with(CategoryContentDecorator) }
          end

          context "the second category's value" do
            let(:expected_contents) { [article_4]}
            subject { related_categories.values[1] }

            it { is_expected.to be_a_decorated_version_of(expected_contents).decorated_with(CategoryContentDecorator) }
          end
        end

        context 'and the second category has two items in it' do
          let(:contents_2) { [article_4, article_5] }

          context "the first category's value" do
            let(:expected_contents) { [article_1, article_2]}
            subject { related_categories.values.first }

            it { is_expected.to be_a_decorated_version_of(expected_contents).decorated_with(CategoryContentDecorator) }
          end

          context "the second category's value" do
            let(:expected_contents) { [article_4, article_5]}
            subject { related_categories.values[1] }

            it { is_expected.to be_a_decorated_version_of(expected_contents).decorated_with(CategoryContentDecorator) }
          end
        end

        context 'and the second category has three items in it' do
          let(:contents_2) { [article_3, article_4, article_5] }

          context "the first category's value" do
            let(:expected_contents) { [article_1, article_2]}
            subject { related_categories.values.first }

            it { is_expected.to be_a_decorated_version_of(expected_contents).decorated_with(CategoryContentDecorator) }
          end

          context "the second category's value" do
            let(:expected_contents) { [article_3, article_4]}
            subject { related_categories.values[1] }

            it { is_expected.to be_a_decorated_version_of(expected_contents).decorated_with(CategoryContentDecorator) }
          end
        end
      end
    end
  end
end
