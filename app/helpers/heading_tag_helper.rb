module HeadingTagHelper
  def heading_tag(text, level: 1, ** args)
    content_tag("h#{level}", text, args.merge('role' => :heading, 'aria-level' => level))
  end
end
