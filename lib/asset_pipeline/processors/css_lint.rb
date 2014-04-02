module AssetPipeline
  module Processors
    class CssLint < Sprockets::Processor
      class CssLintError < StandardError; end

      def evaluate(context, locals)
        lint_results = CsslintRuby.run(data, options)

        if lint_results.errors.present?
          error = format_errors(lint_results)
          context.__LINE__ = error
          raise CssLintError.new(error)
        else
          data
        end
      end

      private

      def format_errors(lint_results)
        lint_results.errors.first[:message]
      end

      def options
        @options ||= JSON.parse(IO.read(options_path))
      end

      def options_path
        File.join(Rails.root, '.csslint')
      end
    end
  end
end
