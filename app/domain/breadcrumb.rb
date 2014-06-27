class Breadcrumb
  include Rails.application.routes.url_helpers

  attr_accessor :path, :title

  def initialize(category)
    @path, @title = if category.home?
      [category.path, category.title]
    else
      [category_path(category.id, locale: I18n.locale), category.title]
    end
  end
end
