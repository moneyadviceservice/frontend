RSpec::Matchers.define :have_attributes do |*attributes|
  attributes.each do |attribute|
    failure_message do |entity|
      "#{entity.class} should have attribute #{attribute}"
    end

    match do |entity|
      entity.respond_to?(attribute) and entity.respond_to?(:"#{attribute}=")
    end
  end
end

RSpec::Matchers.define :have_read_only_attributes do |*attributes|
  attributes.each do |attribute|
    failure_message do |entity|
      "#{entity.class} should have read-only attribute #{attribute}"
    end

    match do |entity|
      entity.respond_to?(attribute) and not entity.respond_to?(:"#{attribute}=")
    end
  end
end
