module Core
  class WebChat
    attr_accessor :heading, :description, :additional_one, :additional_two,
                  :additional_three, :small_print

    def initialize(options = {})
      options.each do |key, value|
        send("#{key}=", value) if respond_to?("#{key}=")
      end
    end
  end
end
