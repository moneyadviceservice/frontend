RSpec.describe Core::Repository::Feedback::Email do
  let(:connection) { double }
  let(:feedback_entity) { double }
  subject(:repository) { described_class.new }

  before do
    allow(Core::Registry::Connection).to receive(:[]).with(:internal_email) do
      connection
    end
  end

  describe '#create' do
    let(:recipient) { double }
    let(:subject) { double }
    let(:body) { double }

    let(:expected_email_details) do
      {
        recipient: recipient,
        subject:   subject,
        body:      body
      }
    end

    before do
      allow(repository).to receive(:recipient_for_entity) { recipient }
      allow(repository).to receive(:subject_for_entity) { subject }
      allow(repository).to receive(:body_for_entity) { body }
      allow(connection).to receive(:deliver)
    end

    it 'calls #recipient_for_entity to get the recipient' do
      expect(repository).to receive(:recipient_for_entity).with(feedback_entity)# { recipient }
      repository.create(feedback_entity)
    end

    it 'calls #subject_for_entity to get the recipient' do
      expect(repository).to receive(:subject_for_entity).with(feedback_entity)# { recipient }
      repository.create(feedback_entity)
    end

    it 'calls #recipient_for_entity to get the recipient' do
      expect(repository).to receive(:body_for_entity).with(feedback_entity)# { recipient }
      repository.create(feedback_entity)
    end

    it 'calls deliver on the connection with the right attributes' do
      expect(connection).to receive(:deliver).with(expected_email_details)
      repository.create(feedback_entity)
    end
  end

  describe 'private methods' do
    describe 'recipient_for_entity' do
      subject { repository.send(:recipient_for_entity, entity) }

      context 'when the entity is article feedback' do
        let(:entity) { Core::Feedback::Article.new }

        it 'returns the article feedback email from the rails configuration object' do
          expect(subject).to eql Rails.configuration.article_feedback_email
        end
      end

      context 'when the entity is technical feedback' do
        let(:entity) { Core::Feedback::Technical.new }

        it 'returns the article tecnical email from the rails configuration object' do
          expect(subject).to eql Rails.configuration.technical_feedback_email
        end
      end
    end
  end
end
