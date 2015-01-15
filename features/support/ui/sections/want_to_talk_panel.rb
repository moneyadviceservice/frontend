require_relative '../section'

module UI::Sections
  class WantToTalkPanel < UI::Section
    element :button, '.want-to-talk__trigger__button'
    element :body, '.want-to-talk__body'
    element :phone, '.want-to-talk__body__phone'

    def fixed?
      has_css?('.want-to-talk--fixed')
    end

    def open?
      has_css?('.want-to-talk--open')
    end

    def closed?
      !open?
    end
  end
end
