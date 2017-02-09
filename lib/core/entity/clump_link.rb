module Core
  class ClumpLink < Entity
    attr_accessor :text, :url, :style
    validates_presence_of :text, :url, :style
  end
end
