module NewsletterHelper
  def display_newsletter_form?
    signed_in? && current_user.newsletter_subscription
  end
end
