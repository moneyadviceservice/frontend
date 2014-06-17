module Newsletter
  class SubscriptionDecorator < Draper::Decorator
    delegate :success?

    def success_message
      I18n.t('newsletter.subscription.success')
    end

    def error_message
      h.content_tag(:p, I18n.t('newsletter.subscription.error'), class: 'newsletter__text js-newsletter-error-msg')
    end
  end
end
