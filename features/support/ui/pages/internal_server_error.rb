module UI::Pages
  class InternalServerError < UI::Page
    set_url '/500?locale={locale}'
  end
end
