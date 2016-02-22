RSpec.describe Core::Footer do
  let(:params) do
    {
      label: 'Footer',
      blocks: [
        { 'identifier' => 'raw_web_chat_heading', 'content'=>'Web Chat' },
        { 'identifier' => 'raw_web_chat_description', 'content' => 'Got a question?' },
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
        { 'identifier' => 'raw_contact_small_print', 'content' => '* Calls are free.' },
        { 'identifier' => 'raw_newsletter_heading', 'content' => 'Newsletter' },
        { 'identifier' => 'raw_newsletter_introduction', 'content' => 'FREE money advice newsletter.' },
        { 'identifier' => 'raw_newsletter_small_print', 'content' => 'We will never share your data or spam you.' }
      ]
    }
  end

  subject { described_class.new('footer', params) }

  describe '#web_chat' do
    it 'returns a WebChat object' do
      expect(subject.web_chat).to be_a(Core::WebChat)
    end

    it { expect(subject.web_chat.heading).to eq('Web Chat') }
    it { expect(subject.web_chat.description).to eq('Got a question?') }
    it { expect(subject.web_chat.additional_one).to eq('Monday to Friday, 8am to 8pm') }
    it { expect(subject.web_chat.additional_two).to eq('Saturday, 9am to 1pm') }
    it { expect(subject.web_chat.additional_three).to eq('Sunday and Bank Holidays, closed') }
    it { expect(subject.web_chat.small_print).to eq('some small print') }
  end

  describe '#contact' do
    it 'returns a Contact object' do
      expect(subject.contact).to be_a(Core::Contact)
    end

    it { expect(subject.contact.heading).to eq('Call Us') }
    it { expect(subject.contact.introduction).to eq('Give us a call for free advice') }
    it { expect(subject.contact.phone_number).to eq('555 555 5555 *') }
    it { expect(subject.contact.additional_one).to eq('Monday to Friday, 8am to 8pm') }
    it { expect(subject.contact.additional_two).to eq('Saturday, 9am to 1pm') }
    it { expect(subject.contact.additional_three).to eq('Sunday and Bank Holidays, closed') }
  end
end
