class EmbeddedToolsController < ApplicationController

  def parent_template
    'layouts/engine'
  end

  helper_method :parent_template

end
