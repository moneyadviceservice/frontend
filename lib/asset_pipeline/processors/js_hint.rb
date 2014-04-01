module AssetPipeline
  module Processors
    class JsHint < Sprockets::Processor
      class ErrorsFound < StandardError; end

      def evaluate(context, locals)
        lint_results = JshintRuby.run(data, options)

        if lint_results.errors.present?
          raise ErrorsFound
        else
          data
        end
      end

      private

      def options
        @options ||= JSON.parse(File.read(jshintrc))
      end

      def jshintrc
        @jshintrc ||= File.join(Rails.root, '.jshintrc')
      end
    end
  end
end
