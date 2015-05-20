class Partner < ActiveRecord::Base

  validates :name, :tool_name, :tool_language, :tool_width_unit, :tool_width, presence: true
  validates_with Validators::Email, attributes: [:email]
  validates :email, uniqueness: true
  validates :tool_width, numericality: { only_integer: true, greater_than: 0 }
end
