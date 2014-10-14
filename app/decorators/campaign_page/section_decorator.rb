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

    def title
      I18n.t("#{campaign_name}.#{name}.title")
    end

    def intro
      I18n.t("#{campaign_name}.#{name}.intro")
    end

    def css_name
      name.tr('_', '-')
    end

    private

    def campaign_name
      context[:campaign]
    end
  end
end
