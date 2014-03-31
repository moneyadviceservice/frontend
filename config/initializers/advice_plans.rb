module AdvicePlans
  def self.const_missing(name)
    Class.new do
      def method_missing(*args); end
    end
  end
end
