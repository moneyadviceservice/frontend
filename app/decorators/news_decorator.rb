class NewsDecorator < Draper::CollectionDecorator
  delegate :page

  PAGE_SIZE = 17

  def decorator_class
    NewsArticleDecorator
  end

  def prev_page
    object.page - 1
  end

  def next_page
    object.page + 1
  end

  def next_page?
    object.size == PAGE_SIZE
  end

  def prev_page?
    object.page > 1
  end
end
