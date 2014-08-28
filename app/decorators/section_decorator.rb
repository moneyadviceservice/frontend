class SectionDecorator < Draper::CollectionDecorator
  delegate :name

  def decorator_class
    ArticleDecorator
  end

  def separator?
    object.separator == true
  end

  def css_name
    name.tr("_","-")
  end
end
