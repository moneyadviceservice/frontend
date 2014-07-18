module Core
  module Connection
    # Not defined any exception classes as I'm not sure if sendmail will report errors.
    # Have a feeling it might be a 'fire and forget' sort of thing.
    class Smtp < SimpleDelegator
      def deliver(*args)
        __getobj__.deliver(*args)
      end
    end
  end
end
