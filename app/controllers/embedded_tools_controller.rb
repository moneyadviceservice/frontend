class EmbeddedToolsController < ApplicationController

  def parent_template
    'layouts/constrained'
  end

  helper_method :parent_template

end
