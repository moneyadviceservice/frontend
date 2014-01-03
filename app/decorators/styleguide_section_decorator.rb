class StyleguideSectionDecorator < Draper::Decorator
  delegate :description, :filename, :modifiers

  def name
    object.section
  end
end
