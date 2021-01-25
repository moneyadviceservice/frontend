class PaceController < ApplicationController
  layout 'pace'
  
  EXTERNAL_URLS = ['https://tools.nationaldebtline.org/dat-reg?utm_source=mas&utm_medium=landing-page&utm_campaign=start_demo',
  'https://www.stepchange.org/mas-money-advice.aspx?utm_source=mas&utm_medium=landing-page&utm_campaign=start'].freeze

  def show; end

  def privacy; end

  def online
  	cookies[:_pace_url_id] = rand(EXTERNAL_URLS.count) if cookies[:_pace_url_id].nil?
  	redirect_url = EXTERNAL_URLS[cookies[:_pace_url_id].to_i].html_safe
  	redirect_time = 5
  	@redirect_string = "#{redirect_time};url=#{redirect_url}"
  end

end
