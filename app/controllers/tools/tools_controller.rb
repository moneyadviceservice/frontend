module Tools
  class ToolsController < ApplicationController
    def parent_template
      'layouts/tool'
    end
    helper_method :parent_template
  end
end