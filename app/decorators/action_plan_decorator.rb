require 'html_processor'

class ActionPlanDecorator < Draper::Decorator
  decorates_association :categories, with: CategoryDecorator

  delegate :id, :title, :description

  def alternate_options
    object.alternates.each_with_object({}) do |alternate, hash|
      hash[alternate.hreflang] = alternate.url
    end
  end

  def footer_alternate_options
    Hash[alternate_options.map { |key, value| [key.scan(/\w+/).first, value] }].except(I18n.locale.to_s)
  end

  def canonical_url
    h.action_plan_url(object.id)
  end

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
      [HTMLProcessor::NodeReplacer, ['//div[@class="action-item"]/h3', 'h2']],
    ]
  end
end
