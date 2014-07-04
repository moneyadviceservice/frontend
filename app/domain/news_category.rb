class NewsCategory
  def title
    I18n.t('footer.news')
  end

  def path
    # TODO: change this when news route exists
    I18n.t('footer.news_link')
  end

  def home?
    false
  end

  def news?
    true
  end
end
