module Core
  module Feedback
    class Base
      include ActiveModel::Validations
      include ActiveModel::Conversion
      extend ActiveModel::Naming

      def initialize(attributes = {})
        Array(attributes).each do |name, value|
          send("#{name}=", value) if respond_to?("#{name}=")
        end
      end
    end
  end
end
