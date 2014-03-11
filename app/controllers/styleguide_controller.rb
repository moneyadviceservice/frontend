class StyleguideController < ApplicationController
  layout 'styleguide/documentation'

  def layouts
    render layout: 'styleguide/documentation_1col'
  end

  def pages_homepage
    render layout: 'styleguide/page'
  end

  def pages_search_results
    render layout: 'styleguide/page'
  end

  def pages_top_level_category_page
    render layout: 'styleguide/page'
  end

  def pages_guide
    render layout: 'styleguide/page'
  end

  def pages_category_page_level_two
    render layout: 'styleguide/page'
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
