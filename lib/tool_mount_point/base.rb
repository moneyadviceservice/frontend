module ToolMountPoint
  class Base
    def en_id
      self.class::EN_ID
    end

    def cy_id
      self.class::CY_ID
    end

    def alternate_locale(current_locale)
      { 'en' => 'cy', 'cy' => 'en' }.fetch(current_locale)
    end

    def alternate_tool_id(current_tool_id)
      { en_id => cy_id, cy_id => en_id }.fetch(current_tool_id)
    end
  end
end