module Core
  module Feedback
    RSpec.describe Article do
      let(:attributes) { double }
      subject(:article) { described_class.new(attributes) }

      it { is_expected.to respond_to :useful }
      it { is_expected.to respond_to :useful= }

      it { is_expected.to respond_to :suggestions }
      it { is_expected.to respond_to :suggestions= }

      describe '#recipient' do
        subject { article.recipient }

        it { is_expected.to eq Rails.configuration.article_feedback_email }
      end

      describe '#subject' do
        subject { article.subject }

        it { is_expected.to eq('Article Feedback') }
      end

      describe '#body' do
        let(:useful) { 'Yes' }
        let(:suggestions) { 'Test suggestion' }
        let(:url) { 'fake_url' }
        let(:user_agent) { 'agent' }
        let(:time) { 'time' }
        let(:attributes) do
          {
            useful:      useful,
            suggestions: suggestions,
            url:         url,
            user_agent:  user_agent,
            time:        time
          }
        end
        let(:expected_subject) do
          "Did they find the article useful: Yes\n\nTheir suggestions:\n\nTest suggestion\n\n\n"\
          "Url: fake_url\n\nUser Agent: agent\n\nDate/Time: time"
        end

        subject { article.body }

        it { is_expected.to eq(expected_subject) }
      end
    end
  end
end
