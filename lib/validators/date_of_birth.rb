module Validators
  class DateOfBirth < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      if value.nil?
        original = record.attributes_before_type_cast[attribute.to_s]
        record.errors.add(attribute, 'invalid date') if original.present?
        return
      end
      record.errors.add(attribute, 'invalid date') && return unless valid_date?(value)
      record.errors.add(attribute, 'must be in the past') unless value.to_date.past?
    end

    def valid_date?(value)
      return true if value.is_a?(Date) || value.is_a?(Time)

      d, m, y = value.split('/')
      Date.valid_date?(y.to_i, m.to_i, d.to_i)
    end
  end
end
