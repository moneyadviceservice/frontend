module Core::Newsletter
  class Subscription
    include ActiveModel::Validations
    include Draper::Decoratable

    STATUS = [:error, :success]

    private_constant :STATUS

    attr_accessor :status, :message

    validates :status, inclusion: { in: STATUS }
    validates :message, presence: true, allow_blank: true

    def initialize(status, message)
      self.status = status
      self.message = message
    end

    def success?
      status == :success
    end
  end
end
