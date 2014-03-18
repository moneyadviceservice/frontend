class EntityDecorator < Draper::Decorator
  def canonical_url
    h.send("#{class_name}_url",object.id)
  end

  private

  def class_name
    object.class.name.scan(/\w+/).last.downcase
  end
end
