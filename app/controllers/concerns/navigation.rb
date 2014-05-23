module Navigation
  extend ActiveSupport::Concern

  included do
    helper_method :active_categories
    before_action :clear_active_categories
  end

  private

  def active_categories
    @active_categories
  end

  def active_category(category)
    @active_categories << category
  end

  def clear_active_categories
    @active_categories = []
  end
end
