class WpccController < EmbeddedToolsController
  def exclude_syndicated_iframe_resizer?
    true
  end

  def canonical
    "https://www.moneyhelper.org.uk/#{locale}/pensions-and-retirement/auto-enrolment/workplace-pension-calculator"
  end

  protected

  def category_id
    'pensions-and-retirement'
  end
  helper_method :category_id
end
