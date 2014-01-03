class StyleguideController < ApplicationController
  def css
    @sections ||= Styleguide.new.sections.inject({}) do |h, (k, v)|
      h[k] = StyleguideSectionDecorator.new(v); h
    end
  end
end
