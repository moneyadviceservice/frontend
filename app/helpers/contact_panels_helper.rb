module ContactPanelsHelper
  HOME_PAGE_CSS = 'l-contact-panels--homepage'
  NO_TOP_BORDER_CSS = 'l-contact-panels--no-border-top'
  
  def homepage_css(home_page)
    return unless home_page
    HOME_PAGE_CSS
  end

  def no_top_border_css(border_top)
    return if border_top
    NO_TOP_BORDER_CSS
  end
end
