class ArticleDecorator < Draper::Decorator
  delegate :title, :description

  def content
    object.body.html_safe
  end
end
