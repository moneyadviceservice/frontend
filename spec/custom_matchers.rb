RSpec::Matchers.define :be_a_decorated_version_of do |given_object|
  match do |actual|
    if given_object.is_a?(Array)
      if actual.is_a?(Array) && given_object.size == actual.size
        given_object.zip(actual).all? do |(element_of_given, element_of_actual)|
          element_of_actual.object == element_of_given && element_of_actual.is_a?(@decorator_class)
        end
      else
        false
      end
    else
      actual.object == given_object && actual.is_a?(@decorator_class)
    end
  end

  description do
    if given_object.is_a?(Array)
      "be a decorated version of the collection #{given_object}, decorated with #{@decorator_class}"
    else
      "be a decorated version of #{given_object}, decorated with #{@decorator_class}"
    end
  end

  failure_message_for_should do |actual|
    if given_object.is_a?(Array)
      "expected that all items in #{actual} would be a decorated version of the items in #{given_object}, decorated with #{@decorator_class}"
    else
      "expected that #{actual} would be a decorated version of #{given_object}, decorated with #{@decorator_class}"
    end
  end

  chain :decorated_with do |decorator_class|
    @decorator_class = decorator_class
  end
end
