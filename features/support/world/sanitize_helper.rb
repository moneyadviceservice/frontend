require 'html/sanitizer'

module SanitizeHelper
  def strip_tags(html)
    (@full_sanitizer ||= HTML::FullSanitizer.new).sanitize(html)
  end
end

World(SanitizeHelper)
