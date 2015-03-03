module EngineMountPoint
  class Base
    def en_id
      self.class::EN_ID
    end

    def cy_id
      self.class::CY_ID
    end

    def matches?(request)
      (request.params[:locale] == 'en' && request.params[:engine_id] == en_id) ||
        (request.params[:locale] == 'cy' && request.params[:engine_id] == cy_id)
    end
  end
end
