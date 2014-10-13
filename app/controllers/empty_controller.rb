class EmptyController < ApplicationController
  def show
  end

  private

  def hide_elements_irrelevant_for_third_parties?
    true
  end
  helper_method :hide_elements_irrelevant_for_third_parties?

  def optimizely_include_tag
  end
  helper_method :optimizely_include_tag

  def raw(_stringish)
  end
  helper_method :raw

  def render(*args)
    super
    root = "#{request.protocol}#{request.host_with_port.sub(/:80$/, '')}/"
    response.body = response.body.gsub(%r{href=\"/}, "href=\"#{root}")
  end
end
