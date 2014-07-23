require_relative '../section'

module UI::Sections
  class FeedbackPanel < UI::Section
    element :article_feedback_link, '.t-feedback-panel__article-feedback-link'
    element :technical_feedback_link, '.t-feedback-panel__technical-feedback-link'
    element :advice_link, '.t-feedback-panel__advice-link'
  end
end
