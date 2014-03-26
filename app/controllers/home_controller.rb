class HomeController < ApplicationController
  before_action :home_redirection

  def show

  end

  private

  def home_redirection
    case request.env['REQUEST_URI']
    when '/?locale=en' then redirect_to '/'
    when '/?locale=cy' then redirect_to '/cy'
    end
  end
end
