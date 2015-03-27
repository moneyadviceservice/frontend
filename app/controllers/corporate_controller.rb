class CorporateController < ArticlesController
  decorates_assigned :article, with: CorporateDecorator
  decorates_assigned :category, with: CategoryDecorator

  before_filter :assign_categories
  def index
  end

  private

  def interactor
    Core::CorporateReader.new(params[:id])
  end

  def category_tree(categories)
    Core::CategoryTreeReader.new.call(categories)
  end

  def assign_categories
    @category = Core::CategoryReader.new('corporate-home').call
    assign_active_categories(@category)
    # @other = Core::Registry::Repository[:category].find('corporate')
    # @categories = CategoryNavigationDecorator.decorate_collection(
    #   category_tree(@other['contents']).children
    # )
  end
end
