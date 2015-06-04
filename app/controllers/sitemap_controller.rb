class SitemapController < ApplicationController
  def index
  end

  def robots
    @base_url = request.base_url

    render file: '/sitemap/robots.text.erb'
  end
end
