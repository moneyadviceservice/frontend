class CategoryDecorator < Draper::Decorator
  delegate :title, :description

  def contents
    self.class.decorate_collection(object.contents)
  end

  def path
    h.category_path(object.id)
  end
end
