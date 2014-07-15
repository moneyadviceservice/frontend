module Core
  module Feedback
    class Article < Base
      attr_accessor :useful, :suggestions

      validates_presence_of :useful, :suggestions
    end
  end
end
