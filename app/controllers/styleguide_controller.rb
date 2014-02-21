class StyleguideController < ApplicationController
  layout 'styleguide/documentation'

  def layouts
    render layout: 'styleguide/documentation_1col'
  end

  def pages_homepage
    render layout: 'styleguide/page'
  end

  def pages_guide
    render layout: 'styleguide/page'
  end

  def css_header_non_js
    render layout: 'styleguide/page'
  end

  def css_header_js
    render layout: 'styleguide/page_no_header'
  end

  def pages_action_plan
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
