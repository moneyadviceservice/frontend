class Registry
  Error = Class.new(StandardError)

  class << self
    delegate :[]=, to: :objects

    def [](type)
      objects.fetch(type) do
        raise Error, "'#{type}' not registered"
      end
    end

    private

    def objects
      @objects ||= {}
    end
  end
end
