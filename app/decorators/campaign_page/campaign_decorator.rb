module CampaignPage
  class CampaignDecorator < Draper::CollectionDecorator
    delegate :name, :sections

    def decorator_class
      SectionDecorator
    end

    def context
      { campaign: name }
    end

    def title
      I18n.t("#{name}.title")
    end

    def description
      I18n.t("#{name}.description")
    end

    def canonical_url
      h.campaign_url(name)
    end

    def cost_calculator_link?
      object.cost_calculator_link == true
    end

    def alternate_options
      {
        'en-GB' => h.campaign_path(id: name, locale: :en),
        'cy-GB' => h.campaign_path(id: name, locale: :cy)
      }
    end

    def footer_alternate_options
      if I18n.locale == :en
        { 'cy' => h.campaign_path(id: name, locale: :cy) }
      else
        { 'en' => h.campaign_path(id: name, locale: :en) }
      end
    end

    def intro_html
      I18n.t("#{name}.intro_html").html_safe
    end

    def trust_message?
      I18n.t("#{name}.trust_message", default: '').present?
    end

    def hidden_logo_message
      I18n.t("#{name}.trust_message.hidden_logo")
    end

    def trust_title
      I18n.t("#{name}.trust_message.title")
    end

    def trust_content
      I18n.t("#{name}.trust_message.content_html").html_safe
    end

    def button_content
      I18n.t("#{name}.button_content")
    end

    def cost_calculator_link
      h.link_to(I18n.t("#{name}.button_content"),
                h.tool_path('car-cost-calculator'),
                class: 'button button--primary')
    end
  end
end
