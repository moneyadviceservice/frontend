class CategoryNavigationDecorator < Draper::Decorator
  def path
    if id == 'news'
      h.main_app.url_for('/%s/news' % I18n.locale)
    else
      h.main_app.category_path(id)
    end
  end

  def title
    category.title
  end

  def description
    category.description
  end

  def icon
    category.title.split(/\s|,/).first.downcase
  end

  def contents
    CategoryNavigationDecorator.decorate_collection(object.children)
  end

  def id
    category.id
  end

  private

  def category
    object.content
  end
end
