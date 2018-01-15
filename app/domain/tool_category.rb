class ToolCategory
  attr_reader :id
  delegate :title, to: :entity

  def initialize(category_id)
    @id = category_id.to_s
  end

  def home?
    false
  end

  def news?
    false
  end

  def parent_id
    return '' if @id.empty?
    @entity.try(:parent_id)
  end

  private

  def entity
    @entity ||= Core::CategoryReader.new(id).call
  end
end
