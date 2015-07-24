module Core
  class Customer < Entity
    attr_accessor :first_name, :last_name, :email, :post_code, :age_range,
                  :gender, :state, :topics, :newsletter_subscription,
                  :date_of_birth, :status_code

    def active?
      state == 0
    end

    def attributes
      {
        first_name: first_name,
        last_name: last_name,
        email: email,
        post_code: post_code,
        age_range: age_range,
        gender: gender,
        state: state,
        topics: topics,
        newsletter_subscription: newsletter_subscription,
        date_of_birth: date_of_birth,
        status_code: status_code
      }
    end

    def to_crm_hash
      {
        FirstName: first_name,
        LastName: last_name,
        mas_ContactEmail: email,
        Address1_PostalCode: post_code,
        GenderCode: { Value: GENDER_MAP[gender] },
        mas_AgeRange: { Value: AGE_RANGES_MAP[age_range] },
        BirthDate: iso8601_date_of_birth,
        DoNotBulkEMail: !newsletter_subscription
      }
    end

    private

    AGE_RANGES_MAP = {
      '0-15' => '809610000',
      '16-17' => '809610001',
      '18-20' => '809610002',
      '21-24' => '809610003',
      '25-34' => '809610004',
      '35-44' => '809610005',
      '45-54' => '809610006',
      '55-64' => '809610007',
      '65-74' => '809610008',
      '75+' => '809610009'
    }

    GENDER_MAP = {
      'male' => 1,
      'female' => 2
    }

    def iso8601_date_of_birth
      date_of_birth ? date_of_birth.to_time.utc.iso8601 : nil
    end
  end
end
