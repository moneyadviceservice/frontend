module Core
  class NewsletterSubscription
    include ActiveModel::Validations

    attr_accessor :email

    validates_with Validators::Email, attributes: [:email],
                                      dns_validation?: true

    def initialize(options = {})
      @email = options[:email]
    end
  end
end
