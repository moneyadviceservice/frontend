module PensionChatBannerHelper
  def display_pension_chat_banner?
    request_slug = convert_to_slug(request.path)

    whitelisted_slugs.include? request_slug
  end

  private

  def whitelisted_slugs
    first_level_slugs    +
      second_level_slugs +
      third_level_slugs  +
      landing_page_slugs
  end

  def first_level_slugs
    slugs = []

    %i[en cy].each do |locale|
      cms_category_api_find(locale).links.map do |link|
        slugs << convert_to_slug(link['url'])
      end
    end

    slugs -= homepage_slugs
  end

  def second_level_slugs
    slugs = []

    %i[en cy].each do |locale|
      slugs << cms_category_api_find(locale).contents.map(&:id)
    end

    slugs.flatten.uniq
  end

  def legacy_content_slugs
    slugs = []

    %i[en cy].each do |locale|
      slugs << cms_category_api_find(locale).legacy_contents.map(&:id)
    end

    slugs.flatten.uniq
  end

  def third_level_slugs
    slugs = []

    %i[en cy].each do |locale|
      cms_category_api_find(locale).contents.each do |second_level_category|
        slugs << if second_level_category.type == 'category'
                   second_level_category.contents.map(&:id)
                 else
                   second_level_category.id
                 end
      end
    end

    slugs.flatten.uniq
  end

  def landing_page_slugs
    slugs = []

    {
      en: 'pensions-and-retirement',
      cy: 'pensiynau-ac-ymddeoliad'
    }.each_pair do |locale, id|
      I18n.t('landing_pages.paths.retirements', locale: locale).values.map do |path|
        slugs << path.sub(id, '').sub('/', '')
      end
    end

    slugs.flatten.uniq
  end

  def homepage_slugs
    %w[en cy]
  end

  def cms_category_api_find(locale, id = 'pensions-and-retirement')
    Mas::Cms::Category.find(id, locale: locale)
  end

  def convert_to_slug(url)
    url.chop! if url.end_with?('/')
    url.split('/').last
  end
end
