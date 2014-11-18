module Validators
  class DateOfBirth < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      if value.nil?
        original = record.attributes_before_type_cast[attribute.to_s]
        record.errors.add(attribute, 'invalid date') if original.present?
        return
      end

      record.errors.add(attribute, 'must be in the past') unless value.past?
    end
  end
end
