class SectionDecorator < Draper::CollectionDecorator
  delegate :name

  def decorator_class
    ArticleDecorator
  end
end
