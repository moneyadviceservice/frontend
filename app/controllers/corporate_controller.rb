class CorporateController < ArticlesController
  decorates_assigned :article, with: CorporateDecorator

  def index
    @category = Core::Registry::Repository[:category].find('corporate')
    @categories = CategoryNavigationDecorator.decorate_collection(
      category_tree(@category['contents']).children
    )
  end

  private

  def interactor
    Core::CorporateReader.new(params[:id])
  end

  def category_tree(categories)
    Core::CategoryTreeReader.new.call(categories)
  end
end
