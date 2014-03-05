class CategoryDecorator < Draper::Decorator
  delegate :id, :title, :description, :contents
end
