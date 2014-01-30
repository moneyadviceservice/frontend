class CurrentRequestId
  def self.set(value)
    Thread.current['request-id'] = value
  end

  def self.get
    Thread.current['request-id']
  end

  def self.clear!
    Thread.current['request-id'] = nil
  end
end