module Styleguide
  class SectionsController < ApplicationController
    layout 'styleguide'

    def index
      @sections ||= Definition.new.sections.inject({}) do |h, (k, v)|
        h[k] = SectionDecorator.new(v); h
      end
    end
  end
end
