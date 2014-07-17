module ActionDispatch
  class Request
    class Session
      alias_method :original_accessor, :[]
      alias_method :original_mutator, :[]=

      def [](key)
        original_accessor(alternate_key_for_flash(key))
      end

      def []=(key, value)
        original_mutator(alternate_key_for_flash(key), value)
      end

      private

      def alternate_key_for_flash(key)
        if key == 'flash'
          'flash_responsive'
        else
          key
        end
      end
    end
  end
end
