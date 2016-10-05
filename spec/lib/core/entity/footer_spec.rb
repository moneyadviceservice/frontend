RSpec.describe Core::Footer, type: :model do
  let(:params) do
    {
      label: 'Footer',
      blocks: [
        { 'identifier' => 'raw_web_chat_heading', 'content'=>'Web Chat' },
        { 'identifier' => 'raw_web_chat_additional_one', 'content' => 'Monday to Friday, 8am to 8pm' },
        { 'identifier' => 'raw_web_chat_additional_two', 'content' => 'Saturday, 9am to 1pm' },
        { 'identifier' => 'raw_web_chat_additional_three', 'content' => 'Sunday and Bank Holidays, closed' },
        { 'identifier' => 'raw_web_chat_small_print', 'content' => 'some small print' },
        { 'identifier' => 'raw_contact_heading', 'content' => 'Call Us' },
        { 'identifier' => 'raw_contact_introduction', 'content' => 'Give us a call for free advice' },
        { 'identifier' => 'raw_contact_phone_number', 'content' => '555 555 5555 *' },
        { 'identifier' => 'raw_contact_additional_one', 'content' => 'Monday to Friday, 8am to 8pm' },
        { 'identifier' => 'raw_contact_additional_two', 'content' => 'Saturday, 9am to 1pm' },
        { 'identifier' => 'raw_contact_additional_three', 'content' => 'Sunday and Bank Holidays, closed' },
        { 'identifier' => 'raw_contact_small_print', 'content' => '* Calls are free.' }
      ]
    }
  end

  subject { described_class.new('footer', params) }

  describe '#web_chat' do
    it 'returns a WebChat object' do
      expect(subject.web_chat).to be_a(Core::WebChat)
    end

    it "doesn't make multiple instances of web_chat if called multiple times" do
      allow(Core::WebChat).to receive(:new).and_call_original
      3.times { subject.web_chat }
      expect(Core::WebChat).to have_received(:new).once
    end

    it { expect(subject.web_chat.heading).to eq('Web Chat') }
    it { expect(subject.web_chat.additional_one).to eq('Monday to Friday, 8am to 8pm') }
    it { expect(subject.web_chat.additional_two).to eq('Saturday, 9am to 1pm') }
    it { expect(subject.web_chat.additional_three).to eq('Sunday and Bank Holidays, closed') }
    it { expect(subject.web_chat.small_print).to eq('some small print') }
  end

  describe '#contact' do
    it 'returns a Contact object' do
      expect(subject.contact).to be_a(Core::Contact)
    end

    it "doesn't make multiple instances of contact if called multiple times" do
      allow(Core::Contact).to receive(:new).and_call_original
      3.times { subject.contact }
      expect(Core::Contact).to have_received(:new).once
    end

    it { expect(subject.contact.heading).to eq('Call Us') }
    it { expect(subject.contact.introduction).to eq('Give us a call for free advice') }
    it { expect(subject.contact.phone_number).to eq('555 555 5555 *') }
    it { expect(subject.contact.additional_one).to eq('Monday to Friday, 8am to 8pm') }
    it { expect(subject.contact.additional_two).to eq('Saturday, 9am to 1pm') }
    it { expect(subject.contact.additional_three).to eq('Sunday and Bank Holidays, closed') }
  end
end
