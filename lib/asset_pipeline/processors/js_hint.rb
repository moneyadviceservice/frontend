module AssetPipeline
  module Processors
    class JsHint < Sprockets::Processor
      class ErrorsFound < StandardError; end

      REGEX = /#{Regexp.quote(Rails.root.to_s)}\/app\/assets\/.*.js(:?.erb)?\z/

      def evaluate(context, locals)
        if context.pathname.to_s =~ REGEX
          raise ErrorsFound if JshintRuby.run(data, jshint_options).errors.present?
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
