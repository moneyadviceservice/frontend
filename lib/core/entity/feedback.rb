module Core
  class Feedback
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    attr_accessor :type, :subject, :body

    validates_presence_of :type, :subject, :body

    def initialize(attributes = {})
      Array(attributes).each do |name, value|
        send("#{name}=", value) if respond_to?("#{name}=")
      end
    end

  end
end
