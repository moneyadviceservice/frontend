module ActionDispatch
  module Routing
    class RouteSet

      def finalize_with_engine_locale_fix!
        routes.each { |r| r.required_parts << :locale unless r.required_parts.include?(:locale) }

        finalize_without_engine_locale_fix!
      end

      alias_method_chain :finalize!, :engine_locale_fix
    end
  end
end
