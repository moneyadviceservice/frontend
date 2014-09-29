class EmptyController < ApplicationController

  def show
  end

  private

  def optimizely_include_tag
  end
  helper_method :optimizely_include_tag

  def javascript_include_tag(path, options = {})
  end
  helper_method :javascript_include_tag

  def content_for(name)
    super if name != :javascripts
  end
  helper_method :content_for

  def raw(stringish)
  end
  helper_method :raw

  def render(*args)
    super
    root = "#{request.protocol}#{request.host_with_port.sub(/:80$/, "")}/"
    response.body = response.body.gsub(%r{href=\"/}, "href=\"#{root}")
  end
end
