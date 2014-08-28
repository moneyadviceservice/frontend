class CampaignDecorator < Draper::CollectionDecorator
  delegate :name, :sections

  def decorator_class
    SectionDecorator
  end

  def title
    I18n.t("#{name}.title")
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

  def section_title(section)
    I18n.t("#{name}.#{section.name}.title")
  end

  def section_intro(section)
    I18n.t("#{name}.#{section.name}.intro")
  end

  def article_link(section, article)
    h.link_to(I18n.t("#{name}.#{section.name}.#{article.name}.title"),
              h.article_path(article.name))
  end
end
