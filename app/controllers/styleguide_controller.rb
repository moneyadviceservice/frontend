class StyleguideController < ApplicationController
  layout 'styleguide/documentation_1col'

  def layouts
    render layout: 'styleguide/documentation_1col'
  end

  def pages_home
    render layout: 'styleguide/page_unconstrained'
  end

  def pages_search_results
    render layout: 'styleguide/page'
  end

  def pages_parent_category_page
    render layout: 'styleguide/page'
  end

  def pages_grandchild_category_page
    render layout: 'styleguide/page'
  end

  def pages_child_category_page
    render layout: 'styleguide/page'
  end


  def pages_guide
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
