AdvicePlans.parent_controller = '::EmbeddedToolsController'

AdvicePlans.decision_trees_url = lambda do
  "/#{I18n.locale}/tools/#{ToolMountPoint::DecisionTrees::EN_ID}/flow?skip_start_page=true"
end
