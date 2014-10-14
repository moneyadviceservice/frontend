class ToolCategory
  attr_reader :id

  def initialize(category_id)
    @id = category_id.to_s
  end

  def title
    entity.title
  end

  def home?
    false
  end

  def news?
    false
  end

  private

  def entity
    @entity ||= Core::CategoryReader.new(id).call
  end
end
