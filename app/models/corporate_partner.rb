class CorporatePartner < ActiveRecord::Base

  validates :name, :tool_name, :tool_language, :tool_width_unit, :tool_width, presence: true
  validates_with Validators::Email, attributes: [:email]
  validates :email, uniqueness: true
  validates :tool_width, numericality: { only_integer: true, greater_than: 0 }

  def tool_id
    tool_name.downcase.gsub(' ', '_')
  end

  def tool_slug
    tool_name.downcase.gsub(' ', '-')
  end

  def total_tool_width
    tool_width.to_s + tool_width_unit
  end

  def self.to_csv
    attributes = %w(id name email tool_name tool_language tool_width_unit tool_width)

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |corporate_partner|
        csv << attributes.map { |attr| corporate_partner.send(attr) }
      end
    end
  end
end
