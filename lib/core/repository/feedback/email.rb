module Core::Repository
  module Feedback
    class Email < Core::Repository::Base
      def initialize
        self.connection = Core::Registry::Connection[:internal_email]
      end

      def create(entity)
        email_details = {
          recipient: recipient_for_entity(entity),
          subject:   subject_for_entity(entity),
          body:      body_for_entity(entity)
        }
        connection.deliver(email_details)
      end

      private

      attr_accessor :connection

      def recipient_for_entity(entity)
        case entity
        when Core::Feedback::Article
          Rails.configuration.article_feedback_email
        when Core::Feedback::Technical
          Rails.configuration.technical_feedback_email
        end
      end

      def subject_for_entity(entity)
        case entity
        when Core::Feedback::Article
          'Article Feedback'
        when Core::Feedback::Technical
          'Technical Feedback'
        end
      end

      def body_for_entity(entity)
        case entity
        when Core::Feedback::Article
          "Did they find the article useful: #{entity.useful}\n\n" +
          "Their suggestions:\n\n" +
          "#{entity.suggestions}"
        when Core::Feedback::Technical
          "What they were trying to do:\n\n" +
          "#{entity.attempting}\n\n\n" +
          "What happened when they tried:\n\n" +
          "#{entity.occurred}"
        end
      end

    end
  end
end
