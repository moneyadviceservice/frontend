module Core
  class Footer < Entity
    attr_writer :blocks

    def web_chat
      block = @blocks.find do |block|
        block[:identifier] == 'web_chat_times'
      end

      Core::WebChat.new(times: block[:content])
    end
  end
end
