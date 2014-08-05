class EmbeddedToolsController < ApplicationController

  # Prevent repeating of locale param in query string
  Rails::Engine.subclasses.collect(&:instance).each do |engine|
    engine.routes.routes.each { |r| r.required_parts << :locale }
  end

  def parent_template
    'layouts/engine'
  end

  helper_method :parent_template

end
