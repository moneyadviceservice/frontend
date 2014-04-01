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
        @options ||= YAML.load(File.open(
          File.join(Rails.root, 'lib', 'asset_pipeline', 'processors', 'config', 'css_lint_options.yml'))
        )
      end
    end
  end
end
