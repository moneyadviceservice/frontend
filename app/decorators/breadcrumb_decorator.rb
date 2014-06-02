class BreadcrumbDecorator < Draper::Decorator
  def title
    breadcrumb.title
  end

  def path
    breadcrumb.path
  end

  private

  Breadcrumb = Struct.new(:path, :title)

  def breadcrumb
    case object
      when Core::Category
        CategoryDecorator.decorate(object)
      when NilClass
        Breadcrumb.new('/', 'Home')
    end
  end
end
