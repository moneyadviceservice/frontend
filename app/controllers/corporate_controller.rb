class CorporateController < ArticlesController
  decorates_assigned :article, with: CorporateDecorator
  decorates_assigned :category, with: CategoryDecorator

  def index
    @category = Core::CategoryReader.new('corporate-home').call
    assign_active_categories(@category)
  end

  def show
    super
    @category = @article.categories.last
    assign_active_categories(@category)
  end

  private

  def interactor
    Core::CorporateReader.new(params[:id])
  end

  def category_tree(categories)
    Core::CategoryTreeReader.new.call(categories)
  end
end
