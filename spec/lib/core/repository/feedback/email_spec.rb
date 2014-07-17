RSpec.describe Core::Repository::Feedback::Email do
  let(:feedback_entity) { double }
  let(:mailer) { double }
  subject(:repository) { described_class.new }

  before do
    allow(Core::Repository::Feedback::Mailer).to receive(:feedback_email) { mailer }
    allow(mailer).to receive(:deliver)
  end

  describe '#create' do
    it 'calls GeneralMailer.feedback_email to instantiate a mailer' do
      expect(Core::Repository::Feedback::Mailer).to receive(:feedback_email).with(feedback_entity)
      subject.create(feedback_entity)
    end

    it 'calls deliver on the mailer' do
      expect(mailer).to receive(:deliver)
      subject.create(feedback_entity)
    end
  end
end
