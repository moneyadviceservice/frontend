class EmptyController < ApplicationController
  def show; end

  private

  def hide_elements_irrelevant_for_third_parties?
    true
  end
  helper_method :hide_elements_irrelevant_for_third_parties?

  def is_empty_template?
    true
  end
  helper_method :is_empty_template?

  def raw(*); end
  helper_method :raw

  def render(*args)
    super
    root = "#{request.protocol}#{request.host_with_port.sub(/:80$/, '')}/"
    response.body = response.body.gsub(/href=\"\//, "href=\"#{root}")
  end
end
