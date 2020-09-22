class EmptyController < ApplicationController
  def show; end

  private

  def raw(*); end
  helper_method :raw

  def render(*args)
    super
    root = "#{request.protocol}#{request.host_with_port.sub(/:80$/, '')}/"
    response.body = response.body.gsub(/href=\"\//, "href=\"#{root}")
  end
end
