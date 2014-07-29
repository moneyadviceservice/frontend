module Core
  module Feedback
    class Technical < Base
      attr_accessor :attempting, :occurred

      validates_presence_of :attempting, :occurred

      def recipient
        Rails.configuration.technical_feedback_email
      end

      def subject
        'Technical Feedback'
      end

      def body
        "What they were trying to do:\n\n"\
        "#{attempting}\n\n\n"\
        "What happened when they tried:\n\n"\
        "#{occurred}\n\n\n"\
        "Url: #{url}\n\n"\
        "User Agent: #{user_agent}\n\n"\
        "Date/Time: #{time}"
      end
    end
  end
end
