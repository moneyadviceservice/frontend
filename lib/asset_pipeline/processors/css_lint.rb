module AssetPipeline
  module Processors
    class CssLint < Sprockets::Processor
      def evaluate(context, locals)
      #  lint_results = CsslintRuby.run(data)
      #  binding.pry
      #  if lint_results.errors.present?
      #    context.__LINE__ = format_errors(lint_results)
      #    raise "Lint errors"
      #  else
      #    data
      #  end
      data
      end

      private

      def format_errors(lint_results)
        lint_results.errors.first[:message]
      end
    end
  end
end
