class BreadcrumbDecorator < Draper::Decorator
  delegate :path, :title

  protected

  Breadcrumb = Struct.new(:path, :title)

  def object
    case super
      when Core::Category
        CategoryDecorator.decorate(super)
      when NilClass
        Breadcrumb.new(h.root_path, h.t('layouts.home'))
    end
  end
end
