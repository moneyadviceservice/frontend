module Styleguide
  class SectionsController < ApplicationController
    def index
      @sections ||= Definition.instance.sections.inject({}) do |h, (k, v)|
        h[k] = SectionDecorator.new(v); h
      end
    end
  end
end
