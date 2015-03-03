class ValidResource
  BLACKLIST = {
    category:    %w(partners
                    partners-uc-banks
                    partners-uc-landlords
                    resources-for-professionals-working-with-young-people-and-parents)
  }

  attr_accessor :type

  def initialize(type)
    self.type = type
  end

  def matches?(request)
    BLACKLIST[type].exclude?(request.parameters['id'])
  end
end
