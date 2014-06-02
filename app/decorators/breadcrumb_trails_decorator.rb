class BreadcrumbTrailsDecorator < Draper::CollectionDecorator
  def decorate_item(item)
    BreadcrumbDecorator.decorate_collection(item, context: context)
  end
end
