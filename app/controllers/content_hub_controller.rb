class ContentHubController < ApplicationController

  layout 'content_hub'

  def show
  end

  private

  def translation_prefix
    "content_hub.#{params[:slug].gsub(/-/, '_')}"
  end

  helper_method :translation_prefix

end
