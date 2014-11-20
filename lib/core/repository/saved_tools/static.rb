module Core
  module Repository
    module SavedTools
      class Static
        attr_reader :identifier

        def initialize(identifier)
          @identifier = identifier
        end

        def link_copy
          I18n.t("saved_tools.tools.#{identifier}.link_copy")
        end

        def link_url
          I18n.t("saved_tools.tools.#{identifier}.link_url")
        end
      end
    end
  end
end
