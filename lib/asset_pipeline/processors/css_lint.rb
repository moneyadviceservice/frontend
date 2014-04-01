module AssetPipeline
  module Processors
    class CssLint < Sprockets::Processor
      def evaluate(context, locals)
       lint_results = CsslintRuby.run(data, options)
       if lint_results.errors.present?
         context.__LINE__ = format_errors(lint_results)
         raise "Lint errors"
       else
         data
       end
      end

      private

      def format_errors(lint_results)
        lint_results.errors.first[:message]
      end

      def options
        YAML.load(File.open(
          File.join(Rails.root, 'lib', 'asset_pipeline', 'processors', 'config', 'css_lint_options.yml'))
        )
      end
    end
  end
end
