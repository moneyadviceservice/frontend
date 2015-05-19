class CorporateController < ArticlesController
  decorates_assigned :article, with: CorporateDecorator
  decorates_assigned :category, with: CorporateCategoryDecorator

  def index
    @category = corporate_category
    assign_active_categories(@category)
  end

  def show
    super
    set_syndication_tools
    @corporate_category = corporate_category
    @category = @article.categories.last
    assign_active_categories(@corporate_category)
  end

  private

  def corporate_category
    @corporate_category ||= Core::CategoryReader.new('corporate-home').call
  end

  def set_syndication_tools
    @syndication_tools ||= Core::CategoryReader.new('syndication').call
  end

  def interactor
    Core::CorporateReader.new(params[:id])
  end

  def category_tree(categories)
    Core::CategoryTreeReader.new.call(categories)
  end
end
