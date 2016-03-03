module Core::Repository
  module Footer
    class Static
      def find(id)
        {
          label: 'Footer',
          blocks: [
            { 'identifier' => 'raw_web_chat_heading', 'content'=> I18n.t('contact_panels.chat.title') },
            { 'identifier' => 'raw_web_chat_additional_one', 'content' => I18n.t('contact.opening_times.weekdays') },
            { 'identifier' => 'raw_web_chat_additional_two', 'content' => I18n.t('contact.opening_times.saturday') },
            { 'identifier' => 'raw_web_chat_additional_three', 'content' => I18n.t('contact.opening_times.sunday') },
            { 'identifier' => 'raw_web_chat_small_print', 'content' => '' },
            { 'identifier' => 'raw_contact_heading', 'content' => I18n.t('contact_panels.call_us.title') },
            { 'identifier' => 'raw_contact_introduction', 'content' => I18n.t('contact_panels.call_us.description') },
            { 'identifier' => 'raw_contact_phone_number', 'content' => I18n.t('contact.telephone_number') },
            { 'identifier' => 'raw_contact_additional_one', 'content' => I18n.t('contact_panels.call_us.opening_times.weekdays') },
            { 'identifier' => 'raw_contact_additional_two', 'content' => I18n.t('contact_panels.call_us.opening_times.saturday') },
            { 'identifier' => 'raw_contact_additional_three', 'content' => I18n.t('contact_panels.call_us.opening_times.sunday') },
            { 'identifier' => 'raw_contact_small_print', 'content' => "* #{I18n.t('contact_panels.call_us.smallprint')}" },
            { 'identifier' => 'raw_newsletter_heading', 'content' => I18n.t('newsletter_subscriptions.title') },
            { 'identifier' => 'raw_newsletter_introduction', 'content' => I18n.t('newsletter_subscriptions.introduction') },
          ]
        }
      end
    end
  end
end
