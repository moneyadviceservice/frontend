RSpec.describe Core::Repository::Footer::Static do
  describe '#find' do
    let(:values) { subject.find('footer')[:blocks].map(&:values) }

    it 'has the web chat heading' do
      expect(values).to include(['raw_web_chat_heading', 'Web chat'])
    end

    it 'has the web chat additional text' do
      expect(values).to include(['raw_web_chat_additional_one', 'Monday to Friday, 8am to 8pm'])
      expect(values).to include(['raw_web_chat_additional_two', 'Saturday, 9am to 1pm'])
      expect(values).to include(['raw_web_chat_additional_three', 'Sunday and Bank Holidays, closed'])
    end

    it 'has the web chat small print' do
      expect(values).to include(['raw_web_chat_small_print', ''])
    end

    it 'has the contact heading' do
      expect(values).to include(['raw_contact_heading', 'Call us'])
    end

    it 'has the contact introduction' do
      expect(values).to include(['raw_contact_introduction', 'Give us a call for free and impartial money advice.'])
    end

    it 'has the contact phone number' do
      expect(values).to include(['raw_contact_phone_number', '0800 138 7777 *'])
    end

    it 'has the contact additional text' do
      expect(values).to include(['raw_contact_additional_one', 'Monday to Friday, 8am to 8pm'])
      expect(values).to include(['raw_contact_additional_two', 'Saturday, 9am to 1pm'])
      expect(values).to include(['raw_contact_additional_three', 'Sunday and Bank Holidays, closed'])
    end

    it 'has the contact small print' do
      expect(values).to include(['raw_contact_small_print', '* Calls are free.'])
    end

    it 'has the newsletter heading' do
      expect(values).to include(['raw_newsletter_heading', 'Newsletter'])
    end

    it 'has the newsletter introduction' do
      expect(values).to include(['raw_newsletter_introduction', '200,000 people are taking care of their money with our FREE money advice newsletter.'])
    end
  end
end
