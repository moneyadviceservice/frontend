module HomeHelper
  def alternate_home_map
    I18n.available_locales.each_with_object({}) do |locale, map|
      map["#{locale}-GB"] = root_url(locale: locale)
    end
  end

  def markdown(text)
    return unless text
    renderer = Redcarpet::Render::HTML.new
    document = Redcarpet::Markdown.new(renderer).render(text)
    remove_p_tags_from(document).html_safe
  end

  private
  def remove_p_tags_from(document)
    Regexp.new(/\A<p>(.*)<\/p>\Z/m).match(document)[1] rescue document
  end
end
