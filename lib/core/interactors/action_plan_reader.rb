require 'core/entities/action_plan'
require 'core/registries/repository'

module Core
  class ActionPlanReader
    attr_accessor :id
    private :id=

    def initialize(id)
      self.id = id
    end

    def call(&block)
      data        = Registries::Repository[:action_plan].find(id)
      action_plan = ActionPlan.new(id, data)

      if action_plan.valid?
        action_plan
      else
        block.call if block_given?
      end
    end
  end
end
