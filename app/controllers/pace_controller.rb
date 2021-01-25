class PaceController < ApplicationController
  layout 'pace'
  EXTERNAL_URLS = ['https://www.one.com/', 'https://www.two.com/'].freeze

  def show
  	@random_url= EXTERNAL_URLS.sample
  end

  def privacy; end

  def online; end
end
