class ArticleDecorator < Draper::Decorator
  delegate :title, :description, :body
end
