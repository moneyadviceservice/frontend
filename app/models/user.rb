class User < ActiveRecord::Base
  VALID_AGE_RANGES = ['0-15', '16-17', '18-20', '21-24', '25-34', '35-44', '45-54', '55-64', '65-74', '75+'].freeze
  CRM_FIELDS = %w[encrypted_email_bidx encrypted_first_name encrypted_post_code newsletter_subscription].freeze

  def field_order
    %i[first_name email password post_code]
  end

  devise :registerable,
         :database_authenticatable,
         :encryptable,
         :lockable,
         :trackable,
         :timeoutable,
         :recoverable
  # :confirmable,
  # :invitable,

  # Add database encryption and blind index for login, name and email
  attr_encrypted :email, :first_name, :last_name, :post_code, :contact_number, :age_range, key: ENV['ATTR_CRYPT_KEY']
  attr_encrypted :date_of_birth, key: ENV['ATTR_CRYPT_KEY'], marshal: true
  blind_index :email, key: ENV['BIDX_CRYPT_KEY']
  blind_index :first_name, key: ENV['BIDX_CRYPT_KEY']
  blind_index :last_name, key: ENV['BIDX_CRYPT_KEY']

  before_validation :compute_blind_index, if: lambda { |u|
    u.encrypted_email_changed? || u.encrypted_first_name_changed? || u.encrypted_last_name_changed?
  }

  before_validation :uppercase_post_code
  before_save :datify_dob

  validates_with Validators::Email, attributes: [:email]
  validates_with Validators::DateOfBirth, attributes: [:date_of_birth]
  validates :email, uniqueness: true
  validates :post_code, presence: true,
                        format: { with: /\A[A-Z]{1,2}\d{1,2}[A-NP-Z]? ?\d[A-Z]{2}\z/, if: 'post_code.present?' },
                        on: :create
  validates :password, presence: true, on: :create
  validates :password, length: 7..128, allow_blank: true
  validates :first_name, presence: true,
                         format: { with: /\A[A-Za-z '-\.]+\z/, if: 'last_name.present?' },
                         length: { maximum: 24 }
  validates :last_name, format: { with: /\A[A-Za-z '-\.]+\z/ },
                        allow_blank: true,
                        length: { maximum: 24 }
  validates :gender, inclusion: { in: %w[female male] }, allow_nil: true
  validates :age_range, inclusion: { in: VALID_AGE_RANGES }, allow_nil: true
  validates :contact_number, format: { with: /\A0[1237]\d{9}\z/, if: 'contact_number.present?' }, allow_blank: true

  before_save :fake_send_confirmation_email

  def self.find_first_by_auth_conditions(conditions)
    User.where(conditions.symbolize_keys).first
  end

  def to_customer
    Converters::UserToCustomer.new(self).call
  end

  def registered?
    !!accept_terms_conditions
  end

  def invitation_sent?
    invitation_sent_at.present?
  end

  def invited_by
    invited_by_id.present?
  end

  def update_goal!(statement, deadline)
    self[:goal_statement] = statement
    self[:goal_deadline] = deadline
    save!
  end

  def send_devise_notification(notification, *args)
    devise_mailer.delay(queue: 'frontend_email').send(notification, self, *args)
  end

  def data_for?(tool_name)
    method = "data_for_#{tool_name}?".to_sym
    send(method) if respond_to?(method)
  end

  def self.find_for_authentication(tainted_conditions)
    if tainted_conditions.key?(:email)
      tainted_conditions[:email] = tainted_conditions[:email].strip.downcase
    end
    find_first_by_auth_conditions(tainted_conditions)
  end

  private

  def compute_blind_index
    compute_email_bidx
    compute_first_name_bidx
    compute_last_name_bidx
  end

  def uppercase_post_code
    post_code.upcase! if post_code
  end

  def datify_dob
    self.date_of_birth = date_of_birth.to_date if date_of_birth
  end

  def fake_send_confirmation_email
    # Temporary fix to trick Devise into thinking an email confirmation is sent to the user
    # so they can sign in desktop site.
    self.confirmation_sent_at = DateTime.now
  end
end
