module CampaignPage
  class SectionDecorator < Draper::CollectionDecorator
    delegate :name

    def decorator_class
      context[:section] = name
      ArticleDecorator
    end

    def separator?
      object.separator == true
    end

    def trust_message?
      I18n.t("#{campaign_name}.#{name}.trust_message", default: '').present?
    end

    def hidden_logo_message
      I18n.t("#{campaign_name}.#{name}.trust_message.hidden_logo")
    end

    def trust_title
      I18n.t("#{campaign_name}.#{name}.trust_message.title")
    end

    def trust_content
      I18n.t("#{campaign_name}.#{name}.trust_message.content_html").html_safe
    end

    def title
      I18n.t("#{campaign_name}.#{name}.title")
    end

    def intro
      I18n.t("#{campaign_name}.#{name}.intro")
    end

    def css_name
      name.tr("_", "-")
    end

    private

    def campaign_name
      context[:campaign]
    end
  end
end
