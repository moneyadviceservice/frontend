module Core
  module Repository
    module RecommendedTools
      class Static
        attr_reader :identifier

        def initialize(identifier)
          @identifier = identifier
        end

        def title
          translate('title')
        end

        def subtitle
          translate('subtitle')
        end

        def link_copy
          translate('link_copy')
        end

        def link_url
          translate('link_url')
        end

        def description
          translate('description')
        end

        def time_to_complete
          translate('time_to_complete')
        end

        def quotee_name
          translate('quotee_name')
        end

        def quotee_location
          translate('quotee_location')
        end

        def quote
          translate('quote')
        end

        private

        def translate(translation)
          I18n.t("recommended_tools.tools.#{identifier}.#{translation}", default: '')
        end
      end
    end
  end
end
