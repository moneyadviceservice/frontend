require_relative 'shared_examples/optional_failure_block'

module Core
  RSpec.describe FeedbackWriter do
    let(:repository) { double }
    let(:entity) { double }

    subject { described_class.new(entity) }

    before do
      allow(Registry::Repository).to receive(:[]).with(:feedback) { repository }
    end

    describe '#call' do
      context 'if the entity is valid' do
        before { allow(entity).to receive(:valid?) { true } }

        it 'calls #create on the repository' do
          expect(repository).to receive(:create).with(entity)
          subject.call
        end
      end

      context 'if the entity is valid' do
        before { allow(entity).to receive(:valid?) { false } }

        it 'does not call #create on the repository' do
          expect(repository).to_not receive(:create)
          subject.call
        end

        it_has_behavior 'optional failure block'
      end
    end
  end
end
