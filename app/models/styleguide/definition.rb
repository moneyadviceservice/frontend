require 'forwardable'
require 'kss/parser'

class Styleguide::Definition
  extend Forwardable

  def_delegator :@parser, :sections

  def initialize(stylesheets_path: Rails.root.join('app/assets/stylesheets'))
    @parser = Kss::Parser.new(stylesheets_path)
  end
end
