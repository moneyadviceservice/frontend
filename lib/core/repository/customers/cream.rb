module Core
  module Repository
    module Customers
      class Cream
        def create(user)
          response = ::Cream::Client.instance.create_customer(user)
          response['contactid']
        end

        def find(options)
          response = ::Cream::Client.instance.find_customer(find_options(options))
          mapping = FindMapper.new(response).call

          return if id_missing_on(mapping)

          Customer.new(mapping[:id], mapping)
        end

        def update(customer)
          ::Cream::Client.instance.update_customer(customer.id, customer.to_crm_hash)
        end

        private

        def id_missing_on(hash)
          hash.try { |mapp| mapp[:id] }.blank?
        end

        def find_options(options)
          { customer_id: options[:id], email: options[:email] }.compact
        end

        class FindMapper
          attr_reader :response

          GENDER_MAP = {
            'male' => 1,
            'female' => 2
          }.freeze
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
          }.freeze
          def initialize(response)
            @response = response
          end

          def call
            return unless response

            {
              id:                      response['contactid'],
              first_name:              response['firstname'],
              last_name:               response['lastname'],
              email:                   response['emailaddress1'],
              post_code:               response['address1_postalcode'],
              state:                   response['statecode'],
              age_range:               age_range(response['mas_agerange']),
              gender:                  gender(response['gendercode']),
              topics:                  response['mas_financialinterest1'],
              newsletter_subscription: !response['donotbulkemail'],
              contact_number:          response['telephone2'],
              date_of_birth:           date_of_birth(response),
              status_code:             response['statuscode']
            }
          end

          private

          def time_in_seconds(date)
            /\/Date\((?<timestamp>.*)\)/.match(date)[:timestamp].to_i / 1000
          end

          def age_range(value)
            AGE_RANGES_MAP.key(value.to_s)
          end

          def date_of_birth(details)
            return if details['BirthDate'].nil?

            Time.at(time_in_seconds(details['BirthDate'])).to_date
          end

          def gender(value)
            GENDER_MAP.key(value)
          end
        end
      end
    end
  end
end
