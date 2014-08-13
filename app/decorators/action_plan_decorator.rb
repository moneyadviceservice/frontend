require 'html_processor'

class ActionPlanDecorator < ContentItemDecorator
  decorates_association :categories, with: CategoryDecorator

  def initialize(object, options = {})
    super
    processors << [HTMLProcessor::NodeReplacer, ['//div[@class="action-item"]//h4', 'h3']]
    processors << [HTMLProcessor::NodeReplacer, ['//div[@class="action-item"]/h3', 'h2']]
  end
end
