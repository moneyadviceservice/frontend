module Core
  module Feedback
    class Base
      include ActiveModel::Validations
      include ActiveModel::Conversion
      extend ActiveModel::Naming

      attr_accessor :url, :user_agent, :time
      validates_presence_of :url, :user_agent, :time

      def initialize(attributes = {})
        Array(attributes).each do |name, value|
          send("#{name}=", value) if respond_to?("#{name}=")
        end
      end
    end
  end
end
