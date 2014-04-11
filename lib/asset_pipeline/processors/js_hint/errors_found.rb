module AssetPipeline
  module Processors
    class JsHint < Sprockets::Processor
      class ErrorsFound < StandardError

        attr_accessor :errors

        def initialize(errors)
          @errors = errors.compact
        end

        def to_s
          "#{error_count} #{'error'.pluralize(error_count)} found on " +
          "#{line_count} #{'line'.pluralize(line_count)}. " +
          "Run 'rake jshint' for a complete report."
        end

        private

        def error_count
          errors.length
        end

        def line_count
          errors.collect { |e| e['line'] }.uniq.length
        end
      end
    end
  end
end
