class CategoryDecorator < Draper::Decorator
  decorates_association :contents, with: CategoryContentDecorator
  decorates_association :legacy_contents, with: CategoryContentDecorator
  delegate :title, :description, :id, :parent_id, :images, :links, :category_promos

  def path
    h.category_path(object.id)
  end

  def canonical_url
    h.category_url(object.id)
  end

  def alternate_options
    I18n.available_locales.each_with_object({}) do |locale, map|
      map["#{locale}-GB"] = h.category_url(locale: locale)
    end
  end

  def render_contents
    partial = if object.legacy?
                'relay_page'
              elsif object.parent?
                'child_categories'
              elsif object.child?
                'content_items_all'
              end

    data = object.legacy? ? legacy_contents : contents

    h.render partial, contents: data
  end

  def large_image
    images['large'] if images.present?
  end

  def small_image
    images['small'] if images.present?
  end

  def images?
    large_image? && small_image?
  end

  def related_links_title
    return if object.contents.blank?

    h.heading_tag(level: 2, class: 'more-in__heading') do
      I18n.t('articles.show.more_in.title_prefix', category: object.title)
    end
  end

  private

  def large_image?
    object.images.present? && object.images['large'].present?
  end

  def small_image?
    object.images.present? && object.images['small'].present?
  end
end
