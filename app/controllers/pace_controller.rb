class PaceController < ApplicationController
  layout 'pace'

  # The online route handles redirection to the external_urls listed here
  # A cookie is set so that a user is always redirected to the same external_url
  # Simply add a new url here if required
  # Do no re-order these urls, as that will mean user's cookies point to the wrong service
  EXTERNAL_URLS = ['https://tools.nationaldebtline.org/dat-reg?utm_source=mas&utm_medium=landing-page&utm_campaign=start_demo',
                   'https://www.stepchange.org/mas-money-advice.aspx?utm_source=mas&utm_medium=landing-page&utm_campaign=start'].freeze

  def show; end

  def privacy; end

  def online
    cookies[:_pace_url_id] = rand(EXTERNAL_URLS.count) if cookies[:_pace_url_id].nil?
    redirect_url = ERB::Util.url_encode(EXTERNAL_URLS[cookies[:_pace_url_id].to_i])
    redirect_time = 3
    @redirect_string = "#{redirect_time};url=#{redirect_url}"
  end

end