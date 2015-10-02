class ChristmasMoneyPlannerController < EmbeddedToolsController
  def show
  end

  protected

  def alternate_url
    alternate_locale = mount_point.alternate_locale(I18n.locale.to_s)
    alternate_tool_id = mount_point.public_send("#{alternate_locale}_id")

    "/#{alternate_locale}/tools/#{alternate_tool_id}"
  end

  def category_id
    'managing-money'
  end

  def mount_point
    @mount_point ||= ToolMountPoint::ChristmasMoneyPlanner.new
  end
end
