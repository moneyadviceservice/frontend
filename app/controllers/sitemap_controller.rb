class SitemapController < ApplicationController
  def index
  end

  def display_skip_to_main_navigation?
    false
  end

  def robots
    @base_url = request.base_url

    render file: '/sitemap/robots.text.erb'
  end
end
