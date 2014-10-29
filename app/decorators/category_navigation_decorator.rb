class CategoryNavigationDecorator < Draper::Decorator
  delegate :id, :title, :description, to: :category

  def path
    if id == 'news'
      h.main_app.url_for('/%s/news' % I18n.locale)
    else
      h.main_app.category_path(id)
    end
  end

  def contents
    CategoryNavigationDecorator.decorate_collection(object.children)
  end

  private

  def category
    object.content
  end
end
