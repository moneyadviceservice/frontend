module Core
  module Repository
    module Customers
      class Cream
        def create(user)
          response = ::Cream::Client.instance.create_customer(user)
          response["d"]["mas_CustomerId"]
        end

        def find(options)
          response = ::Cream::Client.instance.find_customer(find_options(options))
          mapping = FindMapper.new(response).call

          return nil if mapping.nil?

          Customer.new(mapping[:id], mapping)
        end

        def update(customer)
          ::Cream::Client.instance.update_customer(customer.id, customer.to_crm_hash)
        end

        def valid_for_authentication?(id)
          find(id: id)
        end

        private

        def find_options(options)
          { customer_id: options[:id], email: options[:email] }.compact
        end

        class FindMapper
          attr_reader :response

          def initialize(response)
            @response = response
          end

          def call
            if customer_details
              {
                id:                      customer_details["mas_CustomerId"],
                first_name:              customer_details["FirstName"],
                last_name:               customer_details["LastName"],
                email:                   customer_details["EMailAddress1"],
                post_code:               customer_details["Address1_PostalCode"],
                state:                   customer_details["StateCode"]["Value"],
                age_range:               age_range(customer_details["mas_AgeRange"]["Value"]),
                gender:                  gender(customer_details["GenderCode"]["Value"]),
                topics:                  customer_details["mas_FinancialInterest1"],
                newsletter_subscription: !customer_details["DoNotBulkEMail"],
                date_of_birth:           date_of_birth(customer_details),
                status_code:             customer_details["StatusCode"]["Value"]
              }
            end
          end

          private

          def time_in_seconds(date)
            /\/Date\((?<timestamp>.*)\)/.match(date)[:timestamp].to_i / 1000
          end

          def age_range(value)
            AGE_RANGES_MAP.key(value.to_s)
          end

          def date_of_birth(details)
            return if details["BirthDate"].nil?
            Time.at(time_in_seconds(details["BirthDate"])).to_date
          end

          def gender(value)
            GENDER_MAP.key(value)
          end

          GENDER_MAP = {
            "male" => 1,
            "female" => 2,
          }

          AGE_RANGES_MAP = {
              "0-15" => '809610000',
              "16-17" => '809610001',
              "18-20" => '809610002',
              "21-24" => '809610003',
              "25-34" => '809610004',
              "35-44" => '809610005',
              "45-54" => '809610006',
              "55-64" => '809610007',
              "65-74" => '809610008',
              "75+" => '809610009'
          }

          def customer_details
            response["d"]["results"].first
          end
        end
      end
    end
  end
end
