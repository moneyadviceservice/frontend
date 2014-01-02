module Styleguide
  module StyleguideHelper
    def styleguide_section(section, &example)
      partial = 'styleguide/sections/section'

      render layout: partial, locals: { section: section }, &example
    end
  end
end
