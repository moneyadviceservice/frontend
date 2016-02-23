module Core::Repository
  module Footer
    class Fake
      def find(id)
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
            { 'identifier' => 'raw_contact_small_print', 'content' => '* Calls are free.' },
            { 'identifier' => 'raw_newsletter_heading', 'content' => 'Newsletter' },
            { 'identifier' => 'raw_newsletter_introduction', 'content' => 'FREE money advice newsletter.' },
          ]
        }
      end
    end
  end
end
