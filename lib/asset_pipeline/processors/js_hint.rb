module AssetPipeline
  module Processors
    class JsHint < Sprockets::Processor
      class ErrorsFound < StandardError; end

      REGEX = /#{Regexp.quote(Rails.root.to_s)}\/app\/assets\/.*.js\z/

      def evaluate(context, locals)
        if context.pathname.to_s =~ REGEX
          raise ErrorsFound if JshintRuby.run(data, options).errors.present?
        end
        data
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
