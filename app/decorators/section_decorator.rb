class SectionDecorator < Draper::CollectionDecorator
  delegate :name, :separator

  def decorator_class
    ArticleDecorator
  end

  def css_name
    name.tr("_","-")
  end
end
