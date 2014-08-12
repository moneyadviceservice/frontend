require_relative '../section'

module UI::Sections
  class FooterSocialLinks < UI::Section
    element :youtube_link, '.t-youtube-link'
    element :facebook_link, '.t-facebook-link'
    element :twitter_link, '.t-twitter-link'
  end
end
