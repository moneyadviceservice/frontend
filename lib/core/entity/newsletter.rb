module Core
  class Newsletter
    attr_accessor :heading, :introduction

    def initialize(options = {})
      options.each do |key, value|
        send("#{key}=", value) if respond_to?("#{key}=")
      end
    end
  end
end
