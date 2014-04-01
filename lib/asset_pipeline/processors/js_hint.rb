module AssetPipeline
  module Processors
    class JsHint < Sprockets::Processor
      class ErrorsFound < StandardError; end

      def evaluate(context, locals)
        lint_results = JshintRuby.run(data)

        if lint_results.errors.present?
          raise ErrorsFound
        else
          data
        end
      end
    end
  end
end
