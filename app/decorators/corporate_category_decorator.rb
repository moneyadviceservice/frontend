class CorporateCategoryDecorator < CategoryDecorator
  decorates_association :contents, with: CorporateCategoryContentDecorator

  delegate :third_level_navigation

  def render_contents
    h.render partial_path, contents: contents
  end

  private

  def partial_path
    if self.object.third_level_navigation
      'content_items'
    else
      'categories/content_items'
    end
  end
end
