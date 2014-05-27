require 'spec_helper'
require 'core/interactors/category_parents_reader'
require 'core/interactors/category_reader'

module Core
  describe CategoryParentsReader do
    let(:id) { 'subsubcategory-1' }
    let(:category) { Category.new(id, parent_id: parent_id)}

    subject { CategoryParentsReader.new(category) }

    describe '#call' do
      context 'when its a root category' do
        let(:parent_id) { nil }

        it 'returns an empty array' do
          expect(subject.call).to eq([])
        end
      end

      context 'when it is a child category' do
        let(:parent_id) { 'subcategory-1' }
        let(:grandpa_id) { 'category-1' }
        let(:repository) { Repositories::Categories::Fake.new }

        before do
          allow(Registries::Repository).to receive(:[]).with(:category).and_return(repository)
        end

        it 'return parent category on the second place' do
          expect(subject.call.first.id).to eq(grandpa_id)
        end

        it 'retuns grandparent category on the first place' do
          expect(subject.call[1].id).to eq(parent_id)
        end
      end

      context 'when category is nil' do
        let(:category) { nil }
        it 'retuns an empty array' do
          expect(subject.call).to eq([])
        end
      end
    end
  end
end
