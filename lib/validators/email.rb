module Validators
  class Email < ActiveModel::EachValidator
    VALID_REGEX = /\A[A-Z0-9\._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,16}\z/

    def validate_each(record, attribute, value)
      if value.blank?
        record.errors.add(attribute, :blank, value: value)
      elsif invalid_format?(value)
        record.errors.add(attribute, :invalid, value: value)
      end
    end

    private

    def invalid_format?(value)
      value !~ valid_regex
    end

    def valid_regex
      VALID_REGEX
    end
  end
end
