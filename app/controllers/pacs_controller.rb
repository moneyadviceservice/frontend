class PacsController < EmbeddedToolsController
  def canonical
    "https://www.moneyhelper.org.uk/#{locale}/everyday-money/banking/compare-bank-account-fees-and-charges"
  end

  def exclude_syndicated_iframe_resizer?
    true
  end

  protected

  def category_id
    nil
  end
  helper_method :category_id
end
