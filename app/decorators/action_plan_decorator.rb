require 'html_processor'

class ActionPlanDecorator < Draper::Decorator
  delegate :title, :description

  def content
    @content ||= processed_body.html_safe
  end

  private

  def processed_body
    body = object.body

    html_processors.each do |processor, xpaths|
      body = processor.new(body).process(*xpaths)
    end

    body
  end

  def html_processors
    [
      [HTMLProcessor::NodeRemover, HTMLProcessor::INTRO_IMG],
      [HTMLProcessor::NodeReplacer, ['//div[@class="action-item"]//h4', 'h3']],
      [HTMLProcessor::NodeReplacer, ['//div[@class="action-item"]/h3', 'h2']]
    ]
  end
end
