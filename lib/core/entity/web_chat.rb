module Core
  class WebChat
    attr_accessor :times

    def initialize(options = {})
      @times = options[:times]
    end
  end
end
