module Core
  module Repository
    module RecommendedTools
      class Static
        attr_reader :identifier

        def initialize(identifier)
          @identifier = identifier
        end

        def title
          I18n.t("recommended_tools.tools.#{identifier}.title")
        end

        def subtitle
          I18n.t("recommended_tools.tools.#{identifier}.subtitle")
        end

        def link_copy
          I18n.t("recommended_tools.tools.#{identifier}.link_copy")
        end

        def link_url
          I18n.t("recommended_tools.tools.#{identifier}.link_url")
        end

        def description
          I18n.t("recommended_tools.tools.#{identifier}.description")
        end

        def completion_copy
          I18n.t("recommended_tools.tools.#{identifier}.completion_copy")
        end

        def time_to_complete
          I18n.t("recommended_tools.tools.#{identifier}.time_to_complete")
        end

        def quotee_name
          I18n.t("recommended_tools.tools.#{identifier}.quotee_name")
        end

        def quotee_location
          I18n.t("recommended_tools.tools.#{identifier}.quotee_location")
        end

        def quote
          I18n.t("recommended_tools.tools.#{identifier}.quote")
        end
      end
    end
  end
end
