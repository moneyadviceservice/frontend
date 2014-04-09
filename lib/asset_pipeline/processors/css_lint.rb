module AssetPipeline
  module Processors
    class CssLint < Sprockets::Processor
      class CssLintError < StandardError; end

      def evaluate(context, locals)
        lint_results = CsslintRuby.run(comment_ignore_code(data), settings)

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
        lint_results.errors.first['message']
      end

      def comment_ignore_code(data)
        commented_code = data.sub('IgnoreStart */', 'IgnoreStart')
        commented_code.sub('/* @codingStandardsIgnoreEnd', '@codingStandardsIgnoreEnd')
        remove_sass_comments(commented_code)
      end

      def remove_sass_comments(data)
        data.each_line.reject {|line| line =~/line \d+/ }.join
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
