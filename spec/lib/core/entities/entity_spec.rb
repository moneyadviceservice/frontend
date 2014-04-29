require 'spec_helper'
require 'core/entities/entity'

module Core
  describe Entity do
    subject { described_class.new(double, attributes) }

    let(:attributes) { Hash.new }

    it { should respond_to :id }
    it { should_not respond_to :id= }

    it { should validate_presence_of(:id) }

    context 'when passed unexpected data' do
      let(:attributes) { { :foo => :bar } }

      it 'should not raise an exception' do
        expect { subject }.not_to raise_exception
      end
    end

    describe '#==' do
      let(:entity) { Entity.new('foo')}
      subject { entity == other_entity }

      context 'when the other entity is another class' do
        let(:other_entity) { OpenStruct.new(id: 'foo') }

        it { should be_false }
      end

      context 'when the other entity is the same class' do
        context 'when the other entity has the same id' do
          let(:other_entity) { Entity.new('foo')}

          it { should be_true }
        end

        context 'when the other entity has a different id' do
          let(:other_entity) { Entity.new('bar')}

          it { should be_false }
        end
      end
    end
  end
end
