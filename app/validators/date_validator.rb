class DateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, 'invalid date' unless Date.valid?(value)
  end

  class Date
    def self.valid?(value)
      ::Date.parse(value)
      true
    rescue => e
      false
    end
  end
end
