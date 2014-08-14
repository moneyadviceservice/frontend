module Core
  module Feedback
    class Article < Base
      attr_accessor :useful, :suggestions

      validates_presence_of :useful, :suggestions

      def recipient
        Rails.configuration.article_feedback_email
      end

      def subject
        'Article Feedback'
      end

      def body
        "Did they find the article useful: #{useful}\n\n"\
        "Their suggestions:\n\n"\
        "#{suggestions}\n\n\n"\
        "Url: #{url}\n\n"\
        "User Agent: #{user_agent}\n\n"\
        "Date/Time: #{time}"
      end
    end
  end
end
