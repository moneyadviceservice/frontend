module CampaignPage
  class ArticleDecorator < Draper::Decorator
    delegate :name

    def link
      h.link_to(I18n.t("#{campaign_name}.#{section_name}.#{name}.title"),
                h.article_path(name))
    end

    private

    def campaign_name
      context[:campaign]
    end

    def section_name
      context[:section]
    end
  end
end
