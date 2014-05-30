require_relative 'shared_examples/optional_failure_block'
require 'core/interactors/breadcrumbs_reader'

RSpec.describe Core::BreadcrumbsReader do
  subject(:breadcrumbs_reader) { described_class.new(id) }

  let(:id) { 'the-one-we-want' }

  it { is_expected.to respond_to :call }

  describe '.call' do
    before do
      allow(Core::CategoryTreeReader).to receive(:new) { double(call: tree) }
    end

    context 'when the category is not found' do
      let(:tree) { 5.times.collect { Core::Category.new(double) } }

      it_has_behavior 'optional failure block'
    end

    context 'when the category is found' do
      subject(:categories) { breadcrumbs_reader.call }

      context 'at the root of the tree' do
        let(:tree) {
          [
            Core::Category.new(double),
            Core::Category.new(id),
            Core::Category.new(double),
            Core::Category.new(double)
          ]
        }

        it 'returns an array of categories' do
          expect(categories).to be_a(Array)
          expect(categories.first).to be_a(Core::Category)
        end

        context 'the first category returned' do
          subject(:category) { categories.first }

          it 'is the target category' do
            expect(category.id).to eq(id)
          end
        end
      end

      context 'at a branch of the tree' do
        let(:tree) {
          [
            Core::Category.new(double, contents: 3.times.collect { Core::Category.new(double) }),
            Core::Category.new('the-parent', contents: [Core::Category.new(double, parent_id: 'the-parent'), Core::Category.new(id, parent_id: 'the-parent')]),
            Core::Category.new(double, contents: 3.times.collect { Core::Category.new(double) }),
          ]
        }

        it 'returns an array of categories' do
          expect(categories).to be_a(Array)
          expect(categories.first).to be_a(Core::Category)
        end

        it 'finds two categories' do
          expect(categories.size).to eq(2)
        end

        context 'the first category returned' do
          subject(:category) { categories.first }

          it 'is the parent of the target category' do
            expect(category.id).to eq('the-parent')
          end
        end

        context 'the second category returned' do
          subject(:category) { categories.second }

          it 'is the target category' do
            expect(category.id).to eq(id)
          end
        end
      end

      context 'at a twig of the tree' do
        let(:tree) do
          [
            Core::Category.new(double,
                               contents: 3.times.collect { Core::Category.new(double) }),

            Core::Category.new('the-parent',
                               contents: [
                                           Core::Category.new('the-child',
                                                              parent_id: 'the-parent',
                                                              contents:  3.times.collect {
                                                                Core::Category.new(double, parent_id: 'the-child')
                                                              }),

                                           Core::Category.new('the-second-child',
                                                              parent_id: 'the-parent',
                                                              contents:
                                                                         [
                                                                           Core::Category.new(double, parent_id: 'the-second-child'),
                                                                           Core::Category.new(double, parent_id: 'the-second-child'),
                                                                           Core::Category.new(id, parent_id: 'the-second-child')
                                                                         ])
                                         ]),

            Core::Category.new(double,
                               contents: 3.times.collect { Core::Category.new(double) }),
          ]
        end

        it 'finds three categories' do
          expect(categories.size).to eq(3)
        end

        context 'the first category returned' do
          subject(:category) { categories.first }

          it 'is the parent of the target category' do
            expect(category.id).to eq('the-parent')
          end
        end

        context 'the second category returned' do
          subject(:category) { categories.second }

          it 'is the parent of the target category' do
            expect(category.id).to eq('the-second-child')
          end
        end

        context 'the third category returned' do
          subject(:category) { categories.third }

          it 'is the target category' do
            expect(category.id).to eq(id)
          end
        end
      end
    end
  end
end
