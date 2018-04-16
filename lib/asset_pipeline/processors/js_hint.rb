require_relative 'js_hint/errors_found'

module AssetPipeline
  module Processors
    class JsHint < Sprockets::Processor
      JSHINTRC_LOCATION = 'vendor/assets/bower_components/dough/.jshintrc'.freeze
      REGEX = /#{Regexp.quote(Rails.root.to_s)}\/app\/assets\/.*.js(:?.erb)?\z/

      def evaluate(context, _locals)
        if context.pathname.to_s =~ REGEX
          errors = JshintRuby.run(data, jshint_options).errors
          raise ErrorsFound.new(errors) if errors.present?
        end
        data
      end

      private

      def jshint_options
        jshintrc = Rails.root.join(JSHINTRC_LOCATION)
        JSON.parse(File.read(jshintrc))
      end
    end
  end
end
