require_relative '../section'

module UI::Sections
  class FooterSocialLinks < UI::Section
    element :logo, '.icon--masLogo'
    element :youtube_link, '#youtubeLink'
    element :facebook_link, '#facebookLink'
    element :twitter_link, '#twitterLink'
  end
end
