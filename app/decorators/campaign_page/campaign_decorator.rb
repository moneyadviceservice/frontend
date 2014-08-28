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
