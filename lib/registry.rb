class Registry
  Error = Class.new(StandardError)

  class << self
    def []=(type, repository)
      objects[type] = repository
    end

    def [](type)
      objects.fetch(type) do
        raise Error, "`%s' not registered" % type
      end
    end

    private

    def objects
      @objects ||= {}
    end
  end
end
