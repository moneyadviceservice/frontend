require 'spec_helper'
require 'core/repositories/categories/fake'

describe Core::Repositories::Categories::Fake do
  let(:subcategory) { build :category_hash }
  let(:category) { build :category_hash, contents: [subcategory] }
  let(:invalid_id) { 'fake' }
  let(:repository) { described_class.new(category) }

  describe '#all' do
    subject { repository.all }

    it { should be_a(Array) }
    specify { expect(subject.first['id']).to eq(category['id']) }
  end

  describe '#find' do
    context 'when the category exists' do
      subject { repository.find(category['id']) }

      it { should be_a(Hash) }
      specify { expect(subject['id']).to eq(category['id']) }

      it 'instantiates a valid Category' do
        expect(Core::Category.new(subject['id'], subject)).to be_valid
      end

      it 'instantiates a valid Category from the subcategory' do
        subcategory = subject['contents'].first
        expect(Core::Category.new(subcategory['id'], subcategory)).to be_valid
      end

      context 'when retrieving a subcategory' do
        subject { repository.find(subcategory['id']) }

        it { should be_a(Hash) }
        specify { expect(subject['id']).to eq(subcategory['id']) }
      end
    end

    context 'when the category is non-existent' do
      subject { repository.find(invalid_id) }

      it { should be_nil }
    end
  end
end
