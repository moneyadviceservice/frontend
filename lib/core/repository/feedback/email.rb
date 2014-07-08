module Core::Repository
  module Feedback
    class Email
      def create(entity)
        Mailer.feedback_email(entity).deliver
      end
    end

    class Mailer < ActionMailer::Base

      def feedback_email(feedback_entity)

        true
      end
    end
  end
end
