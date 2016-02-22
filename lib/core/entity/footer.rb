module Core
  class Footer < Entity
    attr_writer :blocks

    def contact
      Core::Contact.new(contact_options)
    end

    def newsletter
      Core::Newsletter.new(newsletter_options)
    end

    def web_chat
      Core::WebChat.new(web_chat_options)
    end

    # BaseContentReader attempts to 'build categories', our entity
    # doesn't need them so lets stub out the behaviour to keep it happy.
    def categories
      []
    end

    def categories=(_value)
    end

    private

    def find_block_value(identifier)
      block = @blocks.find { |block| block['identifier'] == identifier }
      block['content']
    end

    def contact_options
      {
        heading: find_block_value('raw_contact_heading'),
        introduction: find_block_value('raw_contact_introduction'),
        phone_number: find_block_value('raw_contact_phone_number'),
        additional_one: find_block_value('raw_contact_additional_one'),
        additional_two: find_block_value('raw_contact_additional_two'),
        additional_three: find_block_value('raw_contact_additional_three'),
        small_print: find_block_value('raw_contact_small_print')
      }
    end

    def newsletter_options
      {
        heading: find_block_value('raw_newsletter_heading'),
        introduction: find_block_value('raw_newsletter_introduction'),
      }
    end

    def web_chat_options
      {
        heading: find_block_value('raw_web_chat_heading'),
        description: find_block_value('raw_web_chat_description'),
        additional_one: find_block_value('raw_web_chat_additional_one'),
        additional_two: find_block_value('raw_web_chat_additional_two'),
        additional_three: find_block_value('raw_web_chat_additional_three'),
        small_print: find_block_value('raw_web_chat_small_print')
      }
    end
  end
end
