class User < ActiveRecord::Base
  VALID_AGE_RANGES = ['0-15', '16-17', '18-20', '21-24', '25-34', '35-44', '45-54', '55-64', '65-74', '75+']

  def field_order
    [:first_name, :email, :password, :post_code]
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

  before_validation :uppercase_post_code

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
  validates :gender, inclusion: { in: %w(female male) }, allow_nil: true
  validates :age_range, inclusion: { in: VALID_AGE_RANGES }, allow_nil: true
  validates :contact_number, format: { with: /\A0[1237]\d{9}\z/, if: 'contact_number.present?'}, allow_blank: true

  before_save :fake_send_confirmation_email
  after_create :create_to_crm
  after_update :update_to_crm

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

  private

  def create_to_crm
    Delayed::Job.enqueue(Jobs::CreateCustomer.new(self.id),
                         queue: 'frontend_crm')
  end

  def update_to_crm
    Delayed::Job.enqueue(Jobs::UpdateFromCustomer.new(self.id),
                         queue: 'frontend_crm')
  end

  def uppercase_post_code
    post_code.upcase! if post_code
  end

  def fake_send_confirmation_email
    # Temporary fix to trick Devise into thinking an email confirmation is sent to the user
    # so they can sign in desktop site.
    self.confirmation_sent_at = DateTime.now
  end
end
