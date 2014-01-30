class StyleguideController < ApplicationController
  layout 'styleguide/documentation'

  def pages_guide
    render layout: 'styleguide/page'
  end

  def layouts
    render layout: 'styleguide/page'
  end

  def pages_error
    render layout: 'styleguide/page'
  end

  private

  def sections
    @sections ||= Styleguide.new.sections.each_with_object({}) do |(k, v), h|
      h[k] = StyleguideSectionDecorator.new(v)
    end
  end

  helper_method :sections
end