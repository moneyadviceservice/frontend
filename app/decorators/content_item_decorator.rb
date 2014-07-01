require 'html_processor'

class ContentItemDecorator < Draper::Decorator
  decorates_association :categories, with: CategoryDecorator

  delegate :title, :description

  def alternate_options
    object.alternates.each_with_object({}) do |alternate, hash|
      hash[alternate.hreflang] = alternate.url
    end
  end

  def footer_alternate_options
    Hash[alternate_options.map { |key, value| [key.scan(/\w+/).first, value] }].except(I18n.locale.to_s)
  end

  def canonical_url
    h.send("#{object.class.to_s.underscore.gsub('core/', '')}_url", object.id)
  end

  def content
    case object
      when Core::StaticPage

        case object.id
          when 'contact-us'
            h.render 'contact_page/en_contact_detail_primary'
          else
            processed_body.html_safe
        end
      else
        processed_body.html_safe
    end
  end

  def secondary_content
    case object
      when Core::StaticPage

        case object.id
          when 'contact-us'
            h.render 'contact_page/en_contact_detail_secondary'
        end
      else
        nil
    end
  end

  def secondary_content?
    !!secondary_content
  end

  private

  def processed_body
    body = object.body

    html_processors.each do |processor, xpaths|
      body = processor.new(body).process(*xpaths)
    end

    body
  end

  def html_processors
    {
      HTMLProcessor::NodeRemover  => [HTMLProcessor::INTRO_IMG,
                                      HTMLProcessor::ACTION_EMAIL,
                                      HTMLProcessor::ACTION_FORM,
                                      HTMLProcessor::COLLAPSIBLE_SPAN
      ],

      HTMLProcessor::VideoWrapper => [HTMLProcessor::VIDEO_IFRAME],

      HTMLProcessor::TableWrapper => [HTMLProcessor::DATATABLE_DEFAULT]
    }
  end
end
