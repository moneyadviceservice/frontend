module StickyNewsletterVisibility
  def display_sticky_newsletter_on_this_slug?
    @slug = request.url.gsub request.base_url, ''
    matches_home_page? || matches_category? ? false : true
  end

  private
   def matches_home_page?
     /^\/(en||cy)$/.match @slug
   end

   def matches_category?
     /\/(en||cy)\/categories\/*/.match @slug
   end
end
