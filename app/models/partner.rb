class Partner < ActiveRecord::Base

  validates :name, :tool_name, :tool_language, :tool_width_unit, :tool_width, presence: true
  validates_with Validators::Email, attributes: [:email]
  validates :email, uniqueness: true
  validates :tool_width, numericality: { only_integer: true, greater_than: 0 }

  def tool_id
    tool_name.downcase.gsub(' ', '-')
  end

  def tool_slug
    tool_id + '-syndication'
  end

  def total_tool_width
    tool_width.to_s + tool_width_unit
  end
end
