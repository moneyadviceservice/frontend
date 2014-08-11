module HeadingTagHelper
  def heading_tag(text, level: 1)
    content_tag("h#{level}", text, 'role' => :heading, 'aria-level' => level)
  end
end
