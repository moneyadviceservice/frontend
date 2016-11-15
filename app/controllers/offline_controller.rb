class OfflineController < ApplicationController

  layout 'offline'

  def show
  end

  private

  def display_search_box_in_header?
    false
  end

  def mobile_nav_in_header?
    false
  end

  def authentication?
    false
  end
end
