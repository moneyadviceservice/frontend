require 'spec_helper'
require 'core/repositories/categories/fake'

describe Core::Repositories::Categories::Fake do
  let(:valid_id) { 'category-1' }
  let(:invalid_id) { 'fake' }

  describe '#all' do
    subject { described_class.new.all }

    it { should be_a(Array) }
    specify { expect(subject.first['id']).to eq(valid_id) }
  end

  describe '#find' do
    context 'when the category exists' do
      subject { described_class.new.find(valid_id) }

      it { should be_a(Hash) }
      specify { expect(subject['id']).to eq(valid_id) }
    end

    context 'when the category is non-existent' do
      subject { described_class.new.find(invalid_id) }

      it { should be_nil }
    end
  end
end
