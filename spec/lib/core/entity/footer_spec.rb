RSpec.describe Core::Footer do
  let(:params) do
    {
      label: 'Footer',
      blocks: [
        { identifier: "web_chat_times", content: "8-5pm" }
      ]
    }
  end

  subject { described_class.new('footer', params) }

  describe '#web_chat' do
    it 'returns a WebChat object' do
      expect(subject.web_chat).to be_a(Core::WebChat)
    end

    it 'includes the web chat times' do
      expect(subject.web_chat.times).to eq('8-5pm')
    end
  end
end
