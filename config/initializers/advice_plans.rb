module AdvicePlans
  ChangeOwnershipCommand = Struct.new(:current_owner)
  StartTaskCommand       = Struct.new(:current_owner, :plan_slug, :task_id, :options)
end

AdvicePlans.parent_controller = '::EmbeddedToolsController'

AdvicePlans.decision_trees_url = lambda do
end
