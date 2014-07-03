module Core
  class ActionPlanReader
    attr_accessor :id
    private :id=

    def initialize(id)
      self.id = id
    end

    def call(&block)
      data        = Registry::Repository[:action_plan].find(id)
      action_plan = ActionPlan.new(id, data)

      if action_plan.valid?
        action_plan.tap do |a|
          a.categories = build_categories(a.categories)
        end
      else
        block.call if block_given?
      end
    end

    private

    def build_categories(category_ids)
      category_ids.map do |category_id|
        CategoryReader.new(category_id).call
      end
    end
  end
end
