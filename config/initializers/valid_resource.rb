class ValidResource
  BLACKLIST = {
    article:     %w(about-our-debt-work am-ein-gwaith-dyled
                    debt-publications cyhoeddiadau-ar-ddyledion
                    partners-overview-parhub
                    partner-reg-parhub
                    syndicating-tools-parhub
                    video-syndication-parhub
                    toolkits-parhub pecynnau-cymorth-cyngor-ariannol
                    linking-parhub
                    examples-parhub
                    licence-agreement-parhub),
    category:    %w(partners
                    partners-uc-banks
                    partners-uc-landlords
                    resources-for-professionals-working-with-young-people-and-parents),
    static_page: %w(accessibility hygyrchedd)
  }

  attr_accessor :type

  def initialize(type)
    self.type = type
  end

  def matches?(request)
    BLACKLIST[type].exclude?(request.parameters['id'])
  end
end
