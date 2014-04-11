require_relative 'js_hint/errors_found'

module AssetPipeline
  module Processors
    class JsHint < Sprockets::Processor

      REGEX = /#{Regexp.quote(Rails.root.to_s)}\/app\/assets\/.*.js(:?.erb)?\z/

      def evaluate(context, locals)
        if context.pathname.to_s =~ REGEX
          errors = JshintRuby.run(data, jshint_options).errors
          raise ErrorsFound.new(errors) if errors.present?
        end
        data
      end

      private

      def jshint_options
        jshintrc = File.join(Rails.root, '.jshintrc')
        JSON.parse(File.read(jshintrc))
      end
    end
  end
end
