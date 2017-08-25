class GeneralEnquiry
  extend ActiveModel::Naming
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include ActiveRecord::AttributeAssignment

  ATTRIBUTES = %i[title first_name surname email type subject message].freeze

  TITLES = %w[mr mrs miss ms dr rev].freeze

  TYPES = %w[
    complaint
    feedback
    enquiry
    invite
    technical
  ].freeze

  SUBJECTS = %w[
    debt_and_borrowing
    budgeting_and_managing_money
    saving_and_investing
    pensions_and_retirement
    work_and_redundancy
    benefits
    births_and_deaths
    insurance
    homes_and_mortgages
    care_and_disability
    cars_and_travel
    other
  ].freeze

  attr_accessor *ATTRIBUTES
  validates :title, inclusion: { in: TITLES }
  validates :first_name, :surname, presence: true
  validates_with Validators::Email, attributes: [:email]
  validates :type, inclusion: { in: TYPES }
  validates :subject, inclusion: { in: SUBJECTS }
  validates :message, length: { within: 20..300 }

  def persisted?
    false
  end
end
