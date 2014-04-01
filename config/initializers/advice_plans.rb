module AdvicePlans
  StartTaskCommand = Struct.new(:current_owner, :plan_slug, :task_id, :options)

  def self.const_missing(name)
    const_set(name, Class.new)
  end
end
