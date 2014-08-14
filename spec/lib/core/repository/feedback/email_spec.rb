RSpec.describe Core::Repository::Feedback::Email do
  let(:connection) { double }
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
    let(:feedback_entity) do
      double(recipient: recipient, subject: subject, body: body)
    end

    let(:expected_email_details) do
      {
        recipient: recipient,
        subject:   subject,
        body:      body
      }
    end

    it 'calls deliver on the connection with the right attributes' do
      expect(connection).to receive(:deliver).with(expected_email_details)

      repository.create(feedback_entity)
    end
  end
end
