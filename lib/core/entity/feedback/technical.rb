module Core
  module Feedback
    class Technical < Base
      attr_accessor :attempting, :occurred

      validates_presence_of :attempting, :occurred
    end
  end
end
