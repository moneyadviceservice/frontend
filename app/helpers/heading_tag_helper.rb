module HeadingTagHelper
  def heading_tag(content_or_options_with_block = nil, options = {}, &block)
    if block_given?
      options = content_or_options_with_block if content_or_options_with_block.is_a?(Hash)
      value   = capture(&block).strip
    else
      value = content_or_options_with_block
    end

    level = options.delete(:level) { 1 }

    content_tag("h#{level}", value.html_safe, options.merge('role' => :heading, 'aria-level' => level))
  end
end
