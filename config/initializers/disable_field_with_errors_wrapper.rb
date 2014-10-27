ActionView::Base.field_error_proc = proc do |html_tag, _|
  html_tag
end
