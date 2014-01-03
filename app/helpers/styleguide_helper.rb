module StyleguideHelper
  def styleguide_section(section, &example)
    partial = 'styleguide/section'

    render layout: partial, locals: { section: section }, &example
  end
end
