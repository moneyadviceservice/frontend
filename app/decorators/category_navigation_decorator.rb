class CategoryNavigationDecorator < Draper::Decorator
  delegate :id, :title, :description, to: :category

  def path
    if news?
      h.main_app.url_for('/%s/news' % I18n.locale)
    elsif corporate_home?
      h.main_app.corporate_index_path
    elsif category_is_corporate?
      h.main_app.corporate_category_path(id)
    else
      h.main_app.category_path(id)
    end
  end

  def contents
    CategoryNavigationDecorator.decorate_collection(object.children)
  end

  def left_nav_items
    data = category.contents || category.legacy_contents
    Core::CategoryReader.new(1).build_contents(data.try(:object)).map! do |item|
      CategoryContentDecorator.new(item)
    end
  end

  def slug
    title.downcase.strip.tr(' ', '-').gsub(/[^\w-]/, '')
  end

  private

  def category
    object.content
  end

  def news?
    id == 'news'
  end

  def corporate_home?
    id == 'corporate-home'
  end

  def category_is_corporate?
    object.content.parent_id == 'corporate-home'
  end
end
