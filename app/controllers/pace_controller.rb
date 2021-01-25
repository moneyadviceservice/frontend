class PaceController < ApplicationController
  layout 'pace'
  EXTERNAL_URLS = ['https://tools.nationaldebtline.org/dat-reg?utm_source=mas&utm_medium=landing-page&utm_campaign=start_demo'.html_safe,
  'https://www.stepchange.org/mas-money-advice.aspx?utm_source=mas&utm_medium=landing-page&utm_campaign=start'.html_safe].freeze

  def show
  	cookies[:_pace_url_id] = rand(EXTERNAL_URLS.count) if cookies[:_pace_url_id].nil?
  	cookies[:_pace_url] = EXTERNAL_URLS[cookies[:_pace_url_id].to_i]
  end

  def privacy; end

  def online; end
end
