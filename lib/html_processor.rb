require 'html_processor/node_remover'
require 'html_processor/node_replacer'
require 'html_processor/video_wrapper'

module HTMLProcessor

  ACTION_EMAIL = '//a[@class="action-email"]'.freeze
  ACTION_FORM  = '//form[@class="action-form"]'.freeze
  INTRO_IMG    = '//p[@class="intro"]/img'.freeze
  VIDEO_IFRAME = '//iframe[starts-with(@src, "https://www.youtube.com/embed")]'.freeze

  VIDEO_TAG_WRAPPER = '<div class="video-wrapper"/>'.freeze
end
