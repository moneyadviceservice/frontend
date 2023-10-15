module AnalyticsHelper
  def analytics_page_name(uri)
    j(uri.split('/').reject { |part| part.start_with?('?') }.last.sub(/\?.*$/, ''))
  end

  def analytics_page_title(title)
    j(Array(title).join(' '))
  end
end
