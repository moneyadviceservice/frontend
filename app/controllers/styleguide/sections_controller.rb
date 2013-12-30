module Styleguide
  class SectionsController < ApplicationController
    def index
      @sections ||= Definition.instance.sections
    end
  end
end
