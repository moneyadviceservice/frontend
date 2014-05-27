class Hash

  def to_ostruct
    OpenStruct.new(self).tap do |ostruct|
      ostruct.each_pair do |attribute, value|
        if value.is_a?(Hash)
          ostruct.send("#{attribute}=", value.to_ostruct)
        elsif value.is_a?(Array)
          value.each_with_index do |element, index|
            if element.respond_to?(:to_ostruct)
              value[index] = element.to_ostruct
            end
          end
        end
      end
    end
  end

end
