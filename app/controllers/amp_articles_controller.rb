class AmpArticlesController < ActionController::Base
  protect_from_forgery with: :exception

  include NotFound

  newrelic_ignore_enduser

  decorates_assigned :article, with: AmpArticleDecorator
  before_action :retrieve_article

  def show
    redirect_to url_for(action: 'show', controller: 'articles', id: @article.id, only_path: false) unless @article.supports_amp || params[:no_redirect]
  end

  def clumps
    Core::ClumpsReader.new.call
  end
  helper_method :clumps

  def category_tree(categories = Core::Registry::Repository[:category].all)
    Core::CategoryTreeReader.new.call(categories)
  end

  def category_tree_with_decorator(categories = Core::Registry::Repository[:category].all)
    Core::CategoryTreeReaderWithDecorator.new.call(categories)
  end

  def navigation_categories
    Core::Registry::Repository[:category].all
  end

  def corporate_categories
    Core::Registry::Repository[:category].find('corporate-categories')['contents']
  end

  def corporate_category?(category, corporate = corporate_categories, categories = [])
    categories << corporate.map {|c| c['id']}
    return true if categories.flatten.include?(category)
    unless corporate.first['contents']
      corporate_category?(category, corporate.first['contents'], categories.flatten)
    end
  end
  
  helper_method :corporate_category?
  
  def category_navigation(corporate = false)
    categories = corporate ? corporate_categories : navigation_categories
    @category_navigation ||= CategoryNavigationDecorator.decorate_collection(category_tree_with_decorator(categories).children)
  end

  helper_method :category_navigation

  def corporate_category_navigation
    @corporate_category_navigation ||= CategoryNavigationDecorator.decorate_collection(category_tree_with_decorator(corporate_categories).children)
  end

  helper_method :corporate_category_navigation

  def hide_elements_irrelevant_for_third_parties?
    false
  end
  
  private

  def retrieve_article
    @article ||= Core::ArticleReader.new(params[:article_id]).call do |error|
      if error.redirect?
        return redirect_to error.location, status: error.status
      else
        not_found
      end
    end
  end
end
