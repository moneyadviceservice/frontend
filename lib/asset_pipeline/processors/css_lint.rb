module AssetPipeline
  module Processors
    class CssLint < Sprockets::Processor
      class CssLintError < StandardError; end

      REGEX = /#{Regexp.quote(Rails.root.to_s)}\/app\/assets\/.*.css\z/
      IGNORED_TAG = '@codingStandardsIgnore'

      def evaluate(context, locals)
        if context.pathname.to_s =~ REGEX
          lint_results = CsslintRuby.run(remove_ignored_code(data), settings)
          raise CssLintError.new(format_errors(lint_results)) if lint_results.errors.present?
        end
        data
      end

      private

      def format_errors(lint_results)
        lint_results.errors.first['message']
      end

      def remove_ignored_code(data)
        data.gsub(/\/\* #{IGNORED_TAG}Start \*\/.+?\/\* #{IGNORED_TAG}End \*\//m, '')
      end

      def settings
        @settings ||= JSON.parse(IO.read(settings_path))
      end

      def settings_path
        File.join(Rails.root, '.csslint')
      end
    end
  end
end
