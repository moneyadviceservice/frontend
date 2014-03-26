class StyleguideSectionDecorator < Draper::Decorator
  delegate :description, :filename, :modifiers

  def id
    "section-#{name.parameterize.dasherize}"
  end

  def name
    object.section
  end
end
