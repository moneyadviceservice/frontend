class VideosController < ApplicationController
  decorates_assigned :video, with: ContentItemDecorator
  decorates_assigned :related_content, with: CategoryDecorator

  include Navigation

  def show
    @video = resource

    set_related_content
    assign_active_categories(*@video.categories)
  end

  private

  def resource
    Mas::Cms::Video.find(params[:id], locale: I18n.locale)
  end

  def set_related_content
    @related_content = CategoriesWithRestrictedContents.build(
      @video.categories,
      RelatedContent.build(@video)
    )
  end
end
