class VideosController < ApplicationController
  decorates_assigned :video, with: ContentItemDecorator
  decorates_assigned :related_content, with: CategoryDecorator

  include Navigation

  def show
    @video = interactor.call do
      not_found
    end

    set_related_content
    set_categories
  end

  private

  def interactor
    Core::VideoReader.new(params[:id])
  end

  def set_related_content
    @related_content = CategoriesWithRestrictedContents.build(@video.categories,
                                                              RelatedContent.build(@video))
  end

  def set_categories
    @video.categories.each do |category|
      active_category category.id
      active_category category.parent_id if category.child?
    end
  end
end
