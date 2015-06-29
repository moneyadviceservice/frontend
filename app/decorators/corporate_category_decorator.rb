class CorporateCategoryDecorator < CategoryDecorator
  decorates_association :contents, with: CorporateCategoryContentDecorator

  delegate :third_level_navigation?

  def render_contents
    h.render partial_path, contents: contents
  end

  private

  def partial_path
    if third_level_navigation?
      'corporate_categories/content_items'
    else
      'corporate_categories/content_items'
    end
  end
end
