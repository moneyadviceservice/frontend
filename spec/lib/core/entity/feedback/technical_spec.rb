module Core
  module Feedback
    RSpec.describe Technical do
      let(:attributes) { double }
      subject(:technical) { described_class.new(attributes) }

      it { is_expected.to respond_to :attempting }
      it { is_expected.to respond_to :attempting= }

      it { is_expected.to respond_to :occurred }
      it { is_expected.to respond_to :occurred= }

      describe '#recipient' do
        subject { technical.recipient }

        it { is_expected.to eq Rails.configuration.technical_feedback_email }
      end

      describe '#subject' do
        subject { technical.subject }

        it { is_expected.to eq('Technical Feedback') }
      end

      describe '#body' do
        let(:attempting) { 'Test attempting' }
        let(:occurred) { 'Test occurred' }
        let(:url) { 'fake_url' }
        let(:user_agent) { 'agent' }
        let(:time) { 'time' }
        let(:attributes) do
          {
            attempting: attempting,
            occurred:   occurred,
            url:        url,
            user_agent: user_agent,
            time:       time
          }
        end
        let(:expected_subject) do
          "What they were trying to do:\n\nTest attempting\n\n\nWhat happened when they tried:\n\n"\
          "Test occurred\n\n\nUrl: fake_url\n\nUser Agent: agent\n\nDate/Time: time"
        end

        subject { technical.body }

        it { is_expected.to eq(expected_subject) }
      end
    end
  end
end
