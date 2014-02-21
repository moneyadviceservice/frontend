require_relative '../section'

module UI::Sections
  class FooterSocialLinks < UI::Section
    element :logo, '.mas-logo-small'
    element :youtube_link, '#youtubeLink'
    element :facebook_link, '#facebookLink'
    element :twitter_link, '#twitterLink'
  end
end
