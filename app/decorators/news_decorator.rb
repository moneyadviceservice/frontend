class NewsDecorator < Draper::CollectionDecorator
  delegate :next_page?, :prev_page?, :next_page_number, :prev_page_number, :page_number

  ALTERNATES_SUFIX = 'GB'

  def decorator_class
    NewsArticleDecorator
  end

  def canonical_url
    h.news_url
  end

  def alternate_options
    I18n.available_locales.each_with_object({}) do |locale, hash|
      hash[:"#{locale}-#{ALTERNATES_SUFIX}"] = h.news_url(locale)
    end
  end
end
