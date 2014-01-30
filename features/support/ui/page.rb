require 'site_prism'

module UI
  class Page < SitePrism::Page
    element :description, :xpath, "//meta[@name='description']", visible: false
  end
end
