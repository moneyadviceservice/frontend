module Core::Newsletter
  class Subscription
    include ActiveModel::Validations
    include Draper::Decoratable

    attr_accessor :success, :message

    validates :success, inclusion: { in: [true, false] }
    validates :message, presence: true, allow_blank: true

    def initialize(success, message)
      self.success = success
      self.message = message
    end

    def success?
      success
    end
  end
end
