module Newsletter
  class SubscriptionDecorator < Draper::Decorator
    delegate :success?

    def message
      if object.success?
        I18n.t('newsletter.subscription.success')
      else
        h.content_tag(:p, I18n.t('newsletter.subscription.error'), class: 'newsletter__text js-newsletter-error-msg')
      end
    end

  end
end
