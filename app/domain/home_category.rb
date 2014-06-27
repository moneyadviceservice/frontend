class HomeCategory
  include Rails.application.routes.url_helpers

  def title
    I18n.t('layouts.home')
  end

  def path
    root_path(locale: I18n.locale)
  end

  def home?
    true
  end
end
