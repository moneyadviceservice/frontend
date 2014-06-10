class CategoryNavigationDecorator < Draper::Decorator
  def path
    if id == 'news'
      h.url_for('/%s/news' % I18n.locale)
    else
      h.category_path(id)
    end
  end

  def title
    category.title
  end

  def description
    category.description
  end

  def contents
    CategoryNavigationDecorator.decorate_collection(object.children)
  end

  private

  def id
    category.id
  end

  def category
    object.content
  end
end
