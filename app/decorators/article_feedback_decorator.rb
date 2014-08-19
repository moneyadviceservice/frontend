class ArticleFeedbackDecorator < Draper::Decorator
  decorates_association :categories, with: CategoryDecorator

  delegate :title

  def feedback_path
    h.article_feedback_path(object.id, locale: I18n.locale)
  end

  def footer_alternate_options
    object.alternates.each_with_object({}) do |alternate, hash|
      hreflang_name = hreflang_name(alternate.hreflang)
      hash[hreflang_name] = alternate.url + '/feedback/new'
    end.except(I18n.locale.to_s)
  end

  private

  def hreflang_name(hreflang)
    hreflang.scan(/\w+/).first
  end
end
