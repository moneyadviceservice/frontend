class Breadcrumb
  include Rails.application.routes.url_helpers

  attr_accessor :path, :title

  def initialize(category)
    @path, @title = if category.nil?
      [root_path(locale: I18n.locale), I18n.t('layouts.home')]
    else
      [category_path(category.id, locale: I18n.locale), category.title]
    end
  end
end
